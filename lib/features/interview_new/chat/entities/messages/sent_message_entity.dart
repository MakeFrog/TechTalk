import 'package:rxdart/rxdart.dart';
import 'package:techtalk/features/interview_new/interview.dart';

class SentMessageEntity extends InterviewMessageEntity {
  final AnswerState answerState;
  final String questionId;

  SentMessageEntity({
    required String message,
    required DateTime timestamp,
    required this.answerState,
    required this.questionId,
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
        questionId: questionId,
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
      questionId: questionId,
    );
  }
}
