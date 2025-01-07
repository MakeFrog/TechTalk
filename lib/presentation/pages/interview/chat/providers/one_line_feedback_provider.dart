import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/use_cases/get_one_line_interview_feedback_use_case.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_message_history_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';

part 'one_line_feedback_provider.g.dart';

///
/// Ai 면접관 한줄 피드백을 stream 형태로 리턴
///
@riverpod
class OneLineFeedback extends _$OneLineFeedback {
  @override
  BehaviorSubject<String> build() {
    final chatHistory = ref.read(chatMessageHistoryProvider).valueOrNull;
    if (chatHistory == null) {
      throw Exception();
    }

    final room = ref.read(selectedChatRoomProvider);

    final topics = ref.read(selectedChatRoomProvider).topics;
    final param = GetOneLineInterViewFeedbackParam(
      chatHistory: chatHistory,
      interviewResult: room.interviewResult,
      interviewType: room.type,
      topic: topics,
      onError: (e, __) {
        log('면접관 한줄 피드백 로드 실패 : $e');
      },
    );
    final result = getOneLineFeedbackUseCase.call(param);
    return result;
  }
}
