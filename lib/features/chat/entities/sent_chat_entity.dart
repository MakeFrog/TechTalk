import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techtalk/features/chat/entities/chat_entity.dart';
import 'package:techtalk/features/chat/enums/answer_state.enum.dart';
import 'package:techtalk/features/chat/enums/chat_type.enum.dart';

@CopyWith()
class SentChatEntity extends ChatEntity {
  final AnswerState answerState;

  SentChatEntity({
    required String message,
    required this.answerState,
  }) : super(
          message: BehaviorSubject.seeded(message)..close(),
          type: ChatType.userReply,
          isStreamApplied: false,
        );

  factory SentChatEntity.create({required String message}) => SentChatEntity(
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
    );
  }
}
