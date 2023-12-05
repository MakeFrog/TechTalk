import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/study/topic_select/study_topic_select_event.dart';
import 'package:techtalk/presentation/pages/study/topic_select/widgets/study_topic_card.dart';
import 'package:techtalk/presentation/pages/study/topic_select/widgets/study_topic_grid_view.dart';
import 'package:techtalk/presentation/providers/study/study_topic_list_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

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
    final studyTopicsAsync = ref.watch(studyTopicListProvider);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: studyTopicsAsync.when(
          loading: SizedBox.new,
          error: (error, stackTrace) => Center(
            child: Text('$error'),
          ),
          data: (data) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final topicAndCategory = data.entries.elementAt(index);

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // TODO : 라벨 공통 요소로 분리
                    _buildCategoryLabel(topicAndCategory.key),
                    const HeightBox(16),
                    StudyTopicGridView(
                      topicList: topicAndCategory.value,
                      topicCardBuilder: (context, index) {
                        final topic = topicAndCategory.value[index];

                        return StudyTopicCard(
                          topic: topic,
                          onTap: () => onTapCard(topic),
                        );
                      },
                    ),
                    const HeightBox(36),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryLabel(String label) {
    return Align(
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
          label,
          style: AppTextStyle.body1.copyWith(
            color: AppColor.of.brand3,
          ),
        ),
      ),
    );
  }
}
