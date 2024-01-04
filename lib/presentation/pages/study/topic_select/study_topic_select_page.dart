import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/study/topic_select/study_topic_select_event.dart';
import 'package:techtalk/presentation/widgets/study_topic_card.dart';

class StudyTopicSelectPage extends HookWidget {
  const StudyTopicSelectPage({super.key});

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
  const _AppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.of.white,
      title: const Text('학습'),
    );
  }
}

class _Body extends ConsumerWidget with StudyTopicSelectEvent {
  const _Body({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topics = getTopicsUseCase().getOrThrow();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 8),
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
              onTap: () => onTapCard(
                ref,
                topic: topic,
              ),
            );
          },
        ),
      ),
    );
  }
}
