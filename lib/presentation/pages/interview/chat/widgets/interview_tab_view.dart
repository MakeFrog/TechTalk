import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/features/chat/entities/enums/interview_progress.enum.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_message_history_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/bubble.dart';

class InterviewTabView extends HookConsumerWidget with ChatState, ChatEvent {
  const InterviewTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final chatScrollController = useScrollController();

    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Consumer(
              builder: (context, ref, _) {
                return chatAsyncAdapterValue(ref).when(
                  data: (_) {
                    final chatMessages = chatMessageHistory(ref);
                    return Align(
                      alignment: Alignment.topCenter,
                      child: ListView.separated(
                        controller: chatScrollController,
                        shrinkWrap: true,
                        reverse: true,
                        padding: const EdgeInsets.only(top: 24, bottom: 20) +
                            const EdgeInsets.symmetric(horizontal: 12),
                        separatorBuilder: (_, __) => const Gap(8),
                        itemCount: chatMessages.length,
                        itemBuilder: (context, index) => Bubble(
                          chat: chatMessages[index],
                          isLatestReceivedChatInEachSection: ref
                              .read(chatMessageHistoryProvider.notifier)
                              .isLastReceivedChatInEachQuestion(index: index),
                          interviewer: interviewer(ref),
                          onReportBtnTapped: () {
                            onReportBtnTapped(ref, index: index);
                          },
                        ),
                      ),
                    );
                  },
                  error: (e, __) => Center(
                    child: Text('채팅 내역을 불러오지 못했습니다[$e]'),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ),

        /// 하단 입력창
        const _BottomInputField(),
      ],
    );
  }
}

class _BottomInputField extends HookConsumerWidget with ChatState, ChatEvent {
  const _BottomInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Container(
        color: AppColor.of.white,
        constraints: const BoxConstraints(minHeight: 48, maxHeight: 240),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: chatAsyncAdapterValue(ref).when(
          data: (_) => _buildTextField(progressState(ref)),
          error: (_, __) => _buildTextField(InterviewProgress.error),
          loading: () => _buildTextField(InterviewProgress.initial),
        ),
      ),
    );
  }

  Widget _buildTextField(InterviewProgress progressState) {
    return HookBuilder(
      builder: (context) {
        final messageController = useTextEditingController();
        final message = useListenableSelector(
          messageController,
          () => messageController.text,
        );
        return Stack(
          children: [
            TextField(
              controller: messageController,
              maxLines: null,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                enabled: progressState.enableChat,
                fillColor: AppColor.of.background1,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                contentPadding: const EdgeInsets.only(
                  right: 42,
                  left: 16,
                  top: 18,
                ),
                hintText: progressState.fieldHintText,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Consumer(
                builder: (context, ref, _) {
                  return IconButton(
                    icon: SvgPicture.asset(
                      Assets.iconsSend,
                      colorFilter: ColorFilter.mode(
                        message.isNotEmpty
                            ? AppColor.of.blue2
                            : AppColor.of.gray3,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: progressState.enableChat
                        ? () {
                            onChatFieldSubmitted(
                              ref,
                              textEditingController: messageController,
                            );
                          }
                        : null,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
