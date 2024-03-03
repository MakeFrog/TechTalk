import 'package:rxdart/rxdart.dart';
import 'package:techtalk/features/chat/chat.dart';

class AnswerChatEntity extends BaseChatEntity {
  final AnswerState answerState;
  final String qnaId;

  AnswerChatEntity({
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

  factory AnswerChatEntity.initial({
    required String message,
    required String qnaId,
  }) =>
      AnswerChatEntity(
        qnaId: qnaId,
        message: message,
      );

  AnswerChatEntity copyWith({
    AnswerState? answerState,
  }) {
    return AnswerChatEntity(
      qnaId: qnaId,
      message: message.value,
      answerState: answerState ?? this.answerState,
    );
  }
}
