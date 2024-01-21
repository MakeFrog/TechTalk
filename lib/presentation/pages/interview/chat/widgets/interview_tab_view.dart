import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_message_history_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/interview_progress_state_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/bubble.dart';

class InterviewTabView extends HookConsumerWidget with ChatEvent {
  const InterviewTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final room = ref.watch(selectedChatRoomProvider);
    final chatScrollController = useScrollController();

    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Consumer(
              builder: (context, ref, _) {
                final chatListAsync = ref.watch(chatMessageHistoryProvider);

                return switch (chatListAsync) {
                  AsyncData(:final value) => Align(
                      alignment: Alignment.topCenter,
                      child: ListView.separated(
                        controller: chatScrollController,
                        shrinkWrap: true,
                        reverse: true,
                        padding: const EdgeInsets.only(top: 24, bottom: 20) +
                            const EdgeInsets.symmetric(horizontal: 12),
                        separatorBuilder: (_, __) => const Gap(8),
                        itemCount: value.length,
                        itemBuilder: (context, index) => Bubble(
                          chat: value[index],
                          isLatestReceivedChatInEachSection: ref
                              .read(chatMessageHistoryProvider.notifier)
                              .isLastReceivedChatInEachQuestion(index: index),
                          interviewer: room.interviewer,
                          onTapReport: value[index] is FeedbackChatMessageEntity
                              ? () => onTapReportButton(
                                    ref,
                                    feedback: value[index]
                                        as FeedbackChatMessageEntity,
                                    answer: value[index + 1]
                                        as AnswerChatMessageEntity,
                                  )
                              : null,
                        ),
                      ),
                    ),
                  AsyncError(error: final e) => Center(
                      child: Text('채팅 내역을 불러오지 못했습니다[$e]'),
                    ),
                  _ => const Center(
                      child: CircularProgressIndicator(),
                    ),
                };

                // return chatListAsync.when(
                //   data: (chatList) {
                //     return Align(
                //       alignment: Alignment.topCenter,
                //       child: ListView.separated(
                //         controller: chatScrollController,
                //         shrinkWrap: true,
                //         reverse: true,
                //         padding: const EdgeInsets.only(top: 24, bottom: 20) +
                //             const EdgeInsets.symmetric(horizontal: 12),
                //         separatorBuilder: (_, __) => const Gap(8),
                //         itemCount: chatList.length,
                //         itemBuilder: (context, index) {
                //           return Bubble(
                //             chat: chatList[index],
                //             isLatestReceivedChatInEachSection: ref
                //                 .read(cchatMessageHistoryProviderroom).notifier)
                //                 .isLastReceivedChatInEachQuestion(index: index),
                //             interviewer: room.interviewerInfo,
                //           );
                //         },
                //       ),
                //     );
                //   },
                //   error: (e, _) => Center(
                //     child: Text('채팅 내역을 불러오지 못했습니다[$e]'),
                //   ),
                //   loading: () => const Center(
                //     child: CircularProgressIndicator(),
                //   ),
                // );
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

class _BottomInputField extends HookConsumerWidget with ChatEvent {
  const _BottomInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interviewState = ref.watch(interviewProgressStateProvider);
    final messageController = useTextEditingController();
    final message = useListenableSelector(
      messageController,
      () => messageController.text,
    );

    return SafeArea(
      child: Container(
        color: AppColor.of.white,
        constraints: const BoxConstraints(minHeight: 48, maxHeight: 240),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Stack(
          children: [
            TextField(
              controller: messageController,
              maxLines: null,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                enabled: interviewState.enableChat,
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
                hintText: interviewState.fieldHintText,
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
                    onPressed: interviewState.enableChat
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
        ),
      ),
    );
  }
}
