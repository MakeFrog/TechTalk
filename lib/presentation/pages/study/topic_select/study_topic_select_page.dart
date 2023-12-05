import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/study/topic_select/study_topic_select_event.dart';
import 'package:techtalk/presentation/providers/study/categorized_study_topics_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
import 'package:techtalk/presentation/widgets/study_topic_card.dart';

class StudyTopicSelectPage extends HookWidget {
  const StudyTopicSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    return const ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          _AppBar(),
          _Body(),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text('학습'),
    );
  }
}

class _Body extends ConsumerWidget with StudyTopicSelectEvent {
  const _Body({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categorizedTopicsAsync = ref.watch(categorizedStudyTopicsProvider);

    final child = categorizedTopicsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text('$error'),
      ),
      data: (topicAndCategories) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: topicAndCategories.length,
          itemBuilder: (context, index) {
            final MapEntry(key: category, value: topics) =
                topicAndCategories.entries.elementAt(index);

            final categoryLabel = Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColor.of.brand1,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  category.text,
                  style: AppTextStyle.body1.copyWith(
                    color: AppColor.of.brand3,
                  ),
                ),
              ),
            );

            final topicGrid = GridView.builder(
              shrinkWrap: true,
              primary: false,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 11,
                mainAxisSpacing: 12,
              ),
              itemCount: topics.length,
              itemBuilder: (context, index) {
                final topic = topics[index];

                return StudyTopicCard(
                  topic: topic,
                  onTap: () => onTapCard(topic),
                );
              },
            );

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                categoryLabel,
                const HeightBox(16),
                topicGrid,
                const HeightBox(36),
              ],
            );
          },
        );
      },
    );

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: child,
      ),
    );
  }
}
