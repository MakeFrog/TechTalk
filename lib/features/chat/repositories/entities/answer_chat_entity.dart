import 'package:rxdart/rxdart.dart';
import 'package:techtalk/features/chat/chat.dart';

class AnswerChatEntity extends BaseChatEntity {
  final AnswerState answerState;
  final String qnaId;
  late String? followUpQuestion;

  bool get isAnwserForRootQuestion => qnaId == rootQnaId;

  AnswerChatEntity({
    super.id,
    required String message,
    DateTime? timestamp,
    this.answerState = AnswerState.loading,
    this.followUpQuestion,
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
    String? followUpQuestion,
  }) {
    return AnswerChatEntity(
      qnaId: qnaId,
      message: message.value,
      followUpQuestion: followUpQuestion ?? this.followUpQuestion,
      answerState: answerState ?? this.answerState,
      rootQnaId: rootQnaId ?? qnaId,
    );
  }

  ///
  /// 꼬리 질문인지 여부
  ///
  bool get isFollowUpQna => qnaId == rootQnaId;
}
