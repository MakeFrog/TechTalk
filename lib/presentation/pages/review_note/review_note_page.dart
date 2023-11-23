import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/review_note/providers/review_question_list_provider.dart';
import 'package:techtalk/presentation/pages/review_note/providers/selected_review_note_topic_provider.dart';
import 'package:techtalk/presentation/pages/review_note/widgets/review_note_topic_chip.dart';
import 'package:techtalk/presentation/pages/review_note/widgets/review_note_topic_list_view.dart';
import 'package:techtalk/presentation/pages/review_note/widgets/review_question_list_view.dart';
import 'package:techtalk/presentation/providers/app_user_data_provider.dart';

class ReviewNotePage extends StatelessWidget {
  const ReviewNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: _AppBar(),
      body: _Body(),
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
      backgroundColor: Colors.white,
      title: const Text('오답노트'),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topicsAsync = ref.watch(appUserDataProvider);

    return topicsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text('$error'),
      ),
      data: (data) {
        final topics =
            data!.techSkillIdList.map(InterviewTopic.getTopicById).toList();
        final selectedTopic =
            ref.watch(selectedReviewNoteTopicProvider).valueOrNull;
        final questionsAsync = ref.watch(reviewQuestionListProvider);

        return Column(
          children: [
            ReviewNoteTopicListView(
              itemCount: topics.length,
              itemBuilder: (context, index) {
                final topic = topics[index];

                return ReviewNoteTopicChip(
                  topic: topic,
                  isSelected: topic.id == selectedTopic?.id,
                  onTap: () {
                    ref.read(selectedReviewNoteTopicProvider.notifier).topic =
                        topic;
                  },
                );
              },
            ),
            questionsAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) {
                return Center(
                  child: Text('${(error as CustomException).message}'),
                );
              },
              data: (data) {
                return ReviewQuestionListView(
                  itemCount: data.length,
                  itemBuilder: (_, index) {
                    final question = data[index];

                    return ReviewQuestionListItem(
                      index: index,
                      question: question,
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
