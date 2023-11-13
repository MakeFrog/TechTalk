import 'package:rxdart/rxdart.dart';
import 'package:techtalk/features/chat/entities/chat_entity.dart';
import 'package:techtalk/features/chat/enums/answer_state.enum.dart';
import 'package:techtalk/features/chat/enums/chat_type.enum.dart';

class SentChatEntity extends ChatEntity {
  final AnswerState answerState;
  final String questionId;

  SentChatEntity({
    required String message,
    required this.answerState,
    required this.questionId,
  }) : super(
          message: BehaviorSubject.seeded(message)..close(),
          type: ChatType.userReply,
          isStreamApplied: false,
        );

  factory SentChatEntity.initial({
    required String message,
    required String questionId,
  }) =>
      SentChatEntity(
        questionId: questionId,
        message: message,
        answerState: AnswerState.loading,
      );

  SentChatEntity copyWith({
    String? message,
    AnswerState? answerState,
  }) {
    return SentChatEntity(
      message: message ?? this.message.value,
      answerState: answerState ?? this.answerState,
      questionId: questionId,
    );
  }
}
