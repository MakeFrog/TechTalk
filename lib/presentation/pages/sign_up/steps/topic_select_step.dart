import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/select_result_chip_list_view.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class TopicSelectStep extends HookConsumerWidget with SignUpEvent {
  const TopicSelectStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final selectedTopics = useState<List<InterviewTopic>>([]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: SignUpStepIntroMessage(
            title: '준비하고 있는 기술면접\n주제를 알려주세요!',
            subTitle: '나중에 선택할 수 있어요.',
          ),
        ),
        SelectResultChipListView(
          itemList: [...selectedTopics.value.map((e) => e.name)],
          onTapItem: selectedTopics.value.removeAt,
        ),
        Gap(16),
        _SearchedSkillListView(
          selectedTopicsNotifier: selectedTopics,
        ),
        _SignUpButton(
          selectedTopicsNotifier: selectedTopics,
        ),
      ],
    );
  }
}

class _SearchedSkillListView extends HookConsumerWidget with SignUpEvent {
  const _SearchedSkillListView({
    super.key,
    required this.selectedTopicsNotifier,
  });

  final ValueNotifier<List<InterviewTopic>> selectedTopicsNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final keyword = useListenableSelector(
      controller,
      () => controller.text,
    );
    final searchTopicsFuture = useMemoized(
      () async => <InterviewTopic>[],
      // () => searchInterviewTopicsUseCase(keyword),
    );
    final searchTopicAsync = useFuture(searchTopicsFuture);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            ClearableTextField(
              controller: controller,
              inputDecoration: const InputDecoration(
                hintText: '관심 기술을 검색해 주세요',
              ),
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (searchTopicAsync.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (searchTopicAsync.hasError) {
                    return Center(
                      child: Text('${searchTopicAsync.error}'),
                    );
                  }
                  final searchTopics = searchTopicAsync.requireData;

                  return ListView.builder(
                    itemCount: searchTopics.length,
                    itemExtent: 52,
                    itemBuilder: (context, index) {
                      final topic = searchTopics[index];

                      final dimmedText = topic.name.replaceAll(keyword, '');

                      return ListTile(
                        minVerticalPadding: 0,
                        title: Align(
                          alignment: Alignment.centerLeft,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: keyword,
                                ),
                                TextSpan(
                                  text: dimmedText,
                                  style: TextStyle(
                                    color: AppColor.of.gray4,
                                  ),
                                ),
                              ],
                            ),
                            style: AppTextStyle.body2,
                          ),
                        ),
                        onTap: () {
                          if (selectedTopicsNotifier.value.contains(topic)) {
                            selectedTopicsNotifier.value.remove(topic);
                          } else {
                            selectedTopicsNotifier.value.add(topic);
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignUpButton extends ConsumerWidget with SignUpEvent {
  const _SignUpButton({
    super.key,
    required this.selectedTopicsNotifier,
  });
  final ValueNotifier<List<InterviewTopic>> selectedTopicsNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FilledButton(
        onPressed: () => onTapSignUp(
          ref,
          topics: selectedTopicsNotifier.value,
        ),
        child: const Center(
          child: Text('회원가입'),
        ),
      ),
    );
  }
}
