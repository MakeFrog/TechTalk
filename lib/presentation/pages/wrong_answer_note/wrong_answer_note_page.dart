import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/selected_wrong_answer_topic_provider.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/wrong_answer_questions_provider.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/wrong_answer_note_event.dart';
import 'package:techtalk/presentation/providers/user/user_topics_provider.dart';

class WrongAnswerNotePage extends HookWidget {
  const WrongAnswerNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    return ColoredBox(
      color: AppColor.of.white,
      child: const Column(
        children: [
          _AppBar(),
          _Body(),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.of.white,
      title: const Text('오답노트'),
    );
  }
}

class _Body extends HookConsumerWidget with WrongAnswerNoteEvent {
  const _Body({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topics = [
      ...ref.watch(userTopicsProvider).where((element) => element.isAvailable),
    ];
    final selectedTopic = ref.watch(selectedWrongAnswerTopicProvider);
    final questionsAsync =
        ref.watch(wrongAnswerQuestionsProvider(selectedTopic.id));

    return Expanded(
      child: Column(
        children: [
          Container(
            height: 32,
            margin: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              itemCount: topics.length,
              separatorBuilder: (context, index) => const Gap(8),
              itemBuilder: (context, index) {
                final topic = topics[index];
                final isSelected = topic.id == selectedTopic.id;

                return ChoiceChip(
                  showCheckmark: false,
                  selected: isSelected,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  backgroundColor: AppColor.of.background1,
                  selectedColor: AppColor.of.brand2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelStyle: AppTextStyle.body1.copyWith(
                    color: isSelected ? Colors.white : AppColor.of.gray3,
                  ),
                  side: BorderSide.none,
                  onSelected: (value) => onTapTopicChip(
                    ref,
                    topic,
                  ),
                  label: Text(topic.name),
                );
              },
            ),
          ),
          Expanded(
            child: questionsAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Text('$error'),
              ),
              data: (questions) {
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: questions.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  itemBuilder: (_, index) {
                    final question = questions[index];

                    return GestureDetector(
                      onTap: () => onTapQuestion(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        child: Text(
                          question.question,
                          style: AppTextStyle.body1,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
