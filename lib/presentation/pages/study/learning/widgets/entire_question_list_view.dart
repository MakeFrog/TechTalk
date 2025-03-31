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
import 'package:techtalk/presentation/widgets/common/animated/animated_size_and_fade.dart';
import 'package:techtalk/presentation/widgets/common/button/app_back_button.dart';
import 'package:techtalk/presentation/widgets/common/button/book_mark_button.dart';
import 'package:techtalk/presentation/widgets/common/input/flat_switch.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_bookmark_filter_provider.dart';

/// 전체 질문 목록을 보여주는 뷰
/// 북마크 필터링 기능을 포함
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
    final isBookmarkFilterActive = this.isShowBookMarkOnlyFilterActive(ref);

    // 북마크 필터링된 리스트 생성
    final filteredQnas = getFilteredQnas(ref, isBookmarkFilterActive);

    final itemKeys = List.generate(
      qnas(ref).length,
      (index) => GlobalKey(),
    );
    final scrollController = useScrollController();

    // 현재 아이템의 필터링된 인덱스 찾기
    final filteredCurrentIndex = getFilteredCurrentIndex(
      ref,
      currentIndex,
      isBookmarkFilterActive,
      filteredQnas,
    );

    usePostFrameEffect(
      () {
        scrollToCurrentItem(
          itemKeys,
          filteredCurrentIndex,
        );
      },
      [filteredCurrentIndex],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(ref, isBookmarkFilterActive),
      body: _buildBody(
        ref,
        scrollController,
        filteredQnas,
        currentIndex,
        itemKeys,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    WidgetRef ref,
    bool isBookmarkFilterActive,
  ) {
    return AppBar(
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
              value: isBookmarkFilterActive,
              bgColor: AppColor.of.blue2,
              onTap: (_) => onToggleBookmarkFilter(ref),
            ),
            const Gap(16),
          ],
        ),
      ],
    );
  }

  Widget _buildBody(
    WidgetRef ref,
    ScrollController scrollController,
    List<SelectableQnaEntity<CommonQnaEntity>> filteredQnas,
    int currentIndex,
    List<GlobalKey> itemKeys,
  ) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: SafeArea(
        child: Column(
          children: [
            ...filteredQnas.asMap().entries.map((entry) {
              final index = entry.key;
              final qna = entry.value;
              final originalIndex =
                  qnas(ref).indexWhere((q) => q.qna.id == qna.qna.id);

              final item = _buildQuestion(
                itemKeys[originalIndex],
                ref,
                index,
                qna,
                originalIndex == currentIndex,
                originalIndex,
              );

              return Column(
                children: [
                  item,
                  if (index != filteredQnas.length - 1)
                    Divider(
                      color: AppColor.of.gray1,
                      height: 1,
                      thickness: 1,
                    ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(
    Key key,
    WidgetRef ref,
    int displayIndex,
    SelectableQnaEntity<CommonQnaEntity> selectableQna,
    bool isSelected,
    int originalIndex,
  ) {
    return Material(
      key: key,
      color: isSelected ? AppColor.of.brand1 : AppColor.of.white,
      child: InkWell(
        onTap: () => Navigator.pop(ref.context, originalIndex),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
          ),
          child: Row(
            children: [
              _buildQuestionNumber(displayIndex, isSelected),
              _buildQuestionText(selectableQna),
              _buildBookmarkButton(ref, selectableQna),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionNumber(int displayIndex, bool isSelected) {
    return SizedBox(
      width: 48,
      child: Text(
        '${displayIndex + 1}',
        textAlign: TextAlign.center,
        style: AppTextStyle.body3.copyWith(
          fontWeight: FontWeight.w700,
          color: isSelected ? AppColor.of.brand3 : AppColor.of.gray3,
        ),
      ),
    );
  }

  Widget _buildQuestionText(
      SelectableQnaEntity<CommonQnaEntity> selectableQna) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Text(
          selectableQna.qna.question,
          style: AppTextStyle.newBody,
        ),
      ),
    );
  }

  Widget _buildBookmarkButton(
    WidgetRef ref,
    SelectableQnaEntity<CommonQnaEntity> selectableQna,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onToggleQnaItemBookmark(ref, selectableQna),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 16),
        child: BookMarkButton(
          bgColor: AppColor.of.background1,
          size: 24,
          radius: 6.4,
          iconWidth: 9.32,
          onTap: () {},
          isBookMarked: selectableQna.isSelected,
        ),
      ),
    );
  }
}
