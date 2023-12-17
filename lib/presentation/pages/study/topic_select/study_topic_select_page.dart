import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/presentation/pages/study/topic_select/study_topic_select_event.dart';
import 'package:techtalk/presentation/providers/topic/categorized_topics_provider.dart';
import 'package:techtalk/presentation/widgets/common/chip/label_chip.dart';
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

class _Body extends StatelessWidget with StudyTopicSelectEvent {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _buildTopicGrid(),
      ),
    );
  }

  Widget _buildTopicGrid() {
    return Consumer(
      builder: (context, ref, child) {
        final categorizedTopics = ref.watch(categorizedTopicsProvider);

        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: categorizedTopics.length,
          separatorBuilder: (context, index) => const Gap(36),
          itemBuilder: (context, index) {
            final MapEntry(key: category, value: topics) =
                categorizedTopics.entries.elementAt(index);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: LabelChip(label: category.text),
                ),
                const Gap(16),
                GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
                const Gap(36),
              ],
            );
          },
        );
      },
    );
  }
}
