import 'package:rxdart/rxdart.dart';
import 'package:techtalk/features/chat/chat.dart';

class AnswerChatMessageEntity extends ChatMessageEntity {
  final AnswerState answerState;
  final String qnaId;

  AnswerChatMessageEntity({
    super.id,
    required String message,
    DateTime? timestamp,
    this.answerState = AnswerState.loading,
    required this.qnaId,
  }) : super(
          type: ChatType.reply,
          isStreamApplied: false,
          message: BehaviorSubject.seeded(message)..close(),
          timestamp: timestamp ?? DateTime.now(),
        );

  factory AnswerChatMessageEntity.initial({
    required String message,
    required String qnaId,
  }) =>
      AnswerChatMessageEntity(
        qnaId: qnaId,
        message: message,
      );

  AnswerChatMessageEntity copyWith({
    AnswerState? answerState,
  }) {
    return AnswerChatMessageEntity(
      qnaId: qnaId,
      message: message.value,
      answerState: answerState ?? this.answerState,
    );
  }
}
