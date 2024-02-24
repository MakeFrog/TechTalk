import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/helper/hook_helper.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/current_study_qna_index_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/widgets/learning_detail_state.dart';
import 'package:techtalk/presentation/widgets/common/button/app_back_button.dart';

class EntireQuestionListView extends HookConsumerWidget
    with LearningDetailState {
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
        title: const Text('전체 문항'),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
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
                      color: AppColor.of.gray2,
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
    );
  }

  Widget _buildQuestion(
    Key key,
    WidgetRef ref,
    int index,
    QnaEntity question,
    bool isSelected,
  ) {
    return Material(
      key: key,
      color: isSelected ? AppColor.of.brand1 : AppColor.of.white,
      child: InkWell(
        onTap: () => Navigator.pop(ref.context, index),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Row(
            children: [
              Text(
                '${index + 1}번',
                style: AppTextStyle.body3.copyWith(
                  color: isSelected ? AppColor.of.brand3 : AppColor.of.gray3,
                ),
              ),
              const Gap(16),
              Expanded(
                child: Text(
                  question.question,
                  style: AppTextStyle.body1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
