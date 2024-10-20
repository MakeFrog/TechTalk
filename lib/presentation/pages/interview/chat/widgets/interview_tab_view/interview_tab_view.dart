import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_message_history_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/bubble.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/interview_tab_view/bottom_input_field.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/interview_tab_view/bottom_speech_to_text_field.dart';
import 'package:techtalk/presentation/widgets/common/animated/animated_size_and_fade.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class InterviewTabView extends HookConsumerWidget with ChatState, ChatEvent {
  const InterviewTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Consumer(
              builder: (context, ref, _) {
                return chatAsyncAdapterValue(ref).when(
                  data: (_) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: ListView.separated(
                        controller: chatScrollController(ref),
                        shrinkWrap: true,
                        reverse: true,
                        padding: const EdgeInsets.only(top: 24, bottom: 20) +
                            const EdgeInsets.symmetric(horizontal: 12),
                        separatorBuilder: (_, __) => const Gap(8),
                        itemCount: ref.watch(
                          chatMessageHistoryProvider
                              .select((value) => value.value?.length ?? 0),
                        ),
                        itemBuilder: (context, index) {
                          return Bubble(
                            chat: chatMessageHistory(ref)[index],
                            isLatestReceivedChatInEachSection: ref
                                .watch(chatMessageHistoryProvider.notifier)
                                .isLastReceivedChatInEachQuestion(
                                  index: index,
                                ),
                            interviewer: interviewer(ref),
                            onReportBtnTapped: () {
                              onReportBtnTapped(ref, index: index);
                            },
                          );
                        },
                      ),
                    );
                  },
                  error: (e, __) => const Center(
                    child: ExceptionIndicator(
                      subTitle: '다시 시도해주세요',
                      title: '채팅 내역을 불러오지 못했어요.',
                    ),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
        ),
        Column(
          children: <Widget>[
            AnimatedSizeAndFade.showHide(
              show: isSpeechMode(ref),
              child: const BottomSpeechToTextField(),
            ),
            AnimatedSizeAndFade.showHide(
              show: !isSpeechMode(ref),
              sizeDuration: Duration.zero,
              child: const BottomInputField(),
            ),
          ],
        ),
        Consumer(
          builder: (context, ref, _) {
            return chatAsyncAdapterValue(ref).when(
              data: (_) {
                listenedInputController(ref);
                interviewProgressState(ref);
                return const EmptyBox();
              },
              error: (_, __) => const EmptyBox(),
              loading: () => const EmptyBox(),
            );
          },
        ),
      ],
    );
  }
}
