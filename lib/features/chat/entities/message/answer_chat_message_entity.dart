import 'package:rxdart/rxdart.dart';
import 'package:techtalk/features/chat/chat.dart';

class AnswerChatMessageEntity extends ChatMessageEntity {
  final AnswerState answerState;
  final String qnaId;

  AnswerChatMessageEntity({
    required String message,
    required DateTime timestamp,
    required this.answerState,
    required this.qnaId,
  }) : super(
          message: BehaviorSubject.seeded(message)..close(),
          type: ChatType.userReply,
          isStreamApplied: false,
          timestamp: timestamp,
        );

  factory AnswerChatMessageEntity.initial({
    required String message,
    required String qnaId,
  }) =>
      AnswerChatMessageEntity(
        qnaId: qnaId,
        message: message,
        answerState: AnswerState.loading,
        timestamp: DateTime.now(),
      );

  AnswerChatMessageEntity copyWith({
    String? message,
    AnswerState? answerState,
    DateTime? timestamp,
  }) {
    return AnswerChatMessageEntity(
      timestamp: timestamp ?? this.timestamp,
      message: message ?? this.message.value,
      answerState: answerState ?? this.answerState,
      qnaId: qnaId,
    );
  }
}
