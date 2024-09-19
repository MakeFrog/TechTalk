import 'package:rxdart/rxdart.dart';
import 'package:techtalk/features/chat/chat.dart';

class AnswerChatEntity extends BaseChatEntity {
  final AnswerState answerState;
  final String qnaId;

  bool get isAnwserForRootQuestion => qnaId == rootQnaId;

  AnswerChatEntity({
    super.id,
    required String message,
    DateTime? timestamp,
    this.answerState = AnswerState.loading,
    required this.qnaId,
    required String rootQnaId,
  }) : super(
          type: ChatType.reply,
          isStreamApplied: false,
          message: BehaviorSubject.seeded(message)..close(),
          timestamp: timestamp ?? DateTime.now(),
          rootQnaId: rootQnaId,
        );

  factory AnswerChatEntity.initial({
    required String message,
    required String qnaId,
    required String rootQnaId,
  }) =>
      AnswerChatEntity(
        qnaId: qnaId,
        message: message,
        rootQnaId: rootQnaId,
      );

  AnswerChatEntity copyWith({
    AnswerState? answerState,
  }) {
    return AnswerChatEntity(
      qnaId: qnaId,
      message: message.value,
      answerState: answerState ?? this.answerState,
      rootQnaId: rootQnaId ?? qnaId,
    );
  }
}
