import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/entities/selectable_qna_entity.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/study/learning/learning_detail_event.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/current_study_qna_index_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/widgets/learning_detail_state.dart';
import 'package:techtalk/presentation/widgets/common/button/app_back_button.dart';
import 'package:techtalk/presentation/widgets/common/button/book_mark_button.dart';
import 'package:techtalk/presentation/widgets/common/input/flat_switch.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_bookmark_filter_provider.dart';

class EntireQuestionListView extends HookConsumerWidget
    with LearningDetailState, LearningDetailEvent {
  const EntireQuestionListView({
    super.key,
    required this.topic,
  });

  final TopicEntity topic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentStudyQnaIndexProvider);

    final itemKeys = List.generate(
      qnas(ref).length,
      (index) => GlobalKey(),
    );
    final scrollController = useScrollController();

    usePostFrameEffect(
      () {
        Scrollable.ensureVisible(itemKeys[currentIndex].currentContext!);
      },
      [],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const AppBackButton(),
        title: Text(tr(LocaleKeys.learning_all_question)),
        titleSpacing: 0,
        actions: [
          Text(
            '북마크 모아보기',
            style: AppTextStyle.alert1,
          ),
          const Gap(6),
          Row(
            children: [
              FlatSwitch(
                height: 24,
                value: isBookmarkFilterActive(ref),
                bgColor: AppColor.of.blue2,
                onTap: (_) => onToggleBookmarkFilter(ref),
              ),
              const Gap(16),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: SafeArea(
          child: Column(
            children: [
              ...qnas(ref).mapIndexed((index, e) {
                final item = _buildQuestion(
                  itemKeys[index],
                  ref,
                  index,
                  qnas(ref)[index],
                  index == currentIndex,
                );
                if (index != qnas(ref).length - 1) {
                  return Column(
                    children: [
                      item,
                      Divider(
                        color: AppColor.of.gray1,
                        height: 1,
                        thickness: 1,
                      ),
                    ],
                  );
                } else {
                  return item;
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(
    Key key,
    WidgetRef ref,
    int index,
    SelectableQnaEntity<CommonQnaEntity> selectableQna,
    bool isSelected,
  ) {
    return Material(
      key: key,
      color: isSelected ? AppColor.of.brand1 : AppColor.of.white,
      child: BounceTapper(
        onTap: () => Navigator.pop(ref.context, index),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                child: Text(
                  '${index + 1}',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.body3.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isSelected ? AppColor.of.brand3 : AppColor.of.gray3,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(
                    selectableQna.qna.question,
                    style: AppTextStyle.newBody,
                  ),
                ),
              ),
              BounceTapper(
                shrinkScaleFactor: 1.0,
                highlightColor: Colors.transparent,
                onTap: () => onToggleQnaItemBookmark(ref, selectableQna.qna),
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: BookMarkButton(
                    bgColor: AppColor.of.background1,
                    size: 24,
                    radius: 6.4,
                    iconWidth: 9.32,
                    onTap: () =>
                        onToggleQnaItemBookmark(ref, selectableQna.qna),
                    isBookMarked: selectableQna.isSelected,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
