import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_state.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/select_result_chip_list_view.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class TopicSelectStep extends HookConsumerWidget with SignUpEvent, SignUpState {
  const TopicSelectStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: SignUpStepIntroMessage(
            title: '준비하고 있는 기술면접\n주제를 알려주세요!',
            subTitle: '나중에 선택할 수 있어요.',
          ),
        ),
        SelectResultChipListView(
          itemList: [...signUpTopics(ref).map((e) => e.text)],
          onTapItem: (index) => onTapSelectedTopic(ref, index),
        ),
        const Gap(16),
        const _SearchedSkillListView(),
        const _SignUpButton(),
      ],
    );
  }
}

class _SearchedSkillListView extends HookConsumerWidget
    with SignUpEvent, SignUpState {
  const _SearchedSkillListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final keyword = useListenableSelector(
      controller,
      () => controller.text,
    );
    final searchedTopics = searchTopicsUseCase(keyword).getOrThrow();

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
              child: ListView.builder(
                itemCount: searchedTopics.length,
                itemExtent: 52,
                itemBuilder: (context, index) {
                  final topic = searchedTopics[index];

                  if (signUpTopics(ref).contains(topic)) {
                    return const SizedBox();
                  }

                  final highlightedText =
                      topic.text.substring(0, keyword.length);
                  final dimmedText = topic.text.substring(keyword.length);

                  return ListTile(
                    minVerticalPadding: 0,
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: highlightedText,
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
                    onTap: () => onTapTopic(
                      ref,
                      item: topic,
                      controller: controller,
                    ),
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

class _SignUpButton extends ConsumerWidget with SignUpEvent, SignUpState {
  const _SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FilledButton(
        onPressed: () => onTapSignUp(ref),
        child: const Center(
          child: Text('회원가입'),
        ),
      ),
    );
  }
}
