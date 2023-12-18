import 'package:rxdart/rxdart.dart';
import 'package:techtalk/features/chat/chat.dart';

class SentMessageEntity extends MessageEntity {
  final AnswerState answerState;
  final String qnaId;

  SentMessageEntity({
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

  factory SentMessageEntity.initial({
    required String message,
    required String questionId,
  }) =>
      SentMessageEntity(
        qnaId: questionId,
        message: message,
        answerState: AnswerState.loading,
        timestamp: DateTime.now(),
      );

  SentMessageEntity copyWith({
    String? message,
    AnswerState? answerState,
    DateTime? timestamp,
  }) {
    return SentMessageEntity(
      timestamp: timestamp ?? this.timestamp,
      message: message ?? this.message.value,
      answerState: answerState ?? this.answerState,
      qnaId: qnaId,
    );
  }
}
