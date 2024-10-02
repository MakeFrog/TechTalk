import 'package:techtalk/features/chat/data_source/remote/models/follow_up_qna_model.dart';
import 'package:techtalk/features/chat/repositories/entities/answer_chat_entity.dart';
import 'package:techtalk/features/chat/repositories/enums/answer_state.enum.dart';

class FollowUpQnaEntity {
  final String id;
  final String? question;
  final String? messageId;
  final AnswerState answerState;

  const FollowUpQnaEntity({
    required this.id,
    this.question,
    this.messageId,
    required this.answerState,
  });

  factory FollowUpQnaEntity.fromAnswerChatEntity(AnswerChatEntity entity) =>
      FollowUpQnaEntity(
        id: entity.qnaId,
        question: entity.followUpQuestion,
        messageId: entity.id,
        answerState: entity.answerState,
      );

  factory FollowUpQnaEntity.fromModel(FollowUpQnaModel model) =>
      FollowUpQnaEntity(
        id: model.id,
        question: model.question,
        messageId: model.messageId,
        answerState: model.state != null
            ? AnswerState.getStateById(
                model.state!,
              )
            : AnswerState.initial,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FollowUpQnaEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          question == other.question &&
          messageId == other.messageId &&
          answerState == other.answerState);

  @override
  int get hashCode =>
      id.hashCode ^
      question.hashCode ^
      messageId.hashCode ^
      answerState.hashCode;

  @override
  String toString() {
    return 'FollowUpQnaEntity{' +
        ' id: $id,' +
        ' question: $question,' +
        ' messageId: $messageId,' +
        ' answerState: $answerState,' +
        '}';
  }

  FollowUpQnaEntity copyWith({
    String? id,
    String? question,
    String? messageId,
    AnswerState? answerState,
  }) {
    return FollowUpQnaEntity(
      id: id ?? this.id,
      question: question ?? this.question,
      messageId: messageId ?? this.messageId,
      answerState: answerState ?? this.answerState,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'question': this.question,
      'messageId': this.messageId,
      'answerState': this.answerState,
    };
  }

  factory FollowUpQnaEntity.fromMap(Map<String, dynamic> map) {
    return FollowUpQnaEntity(
      id: map['id'] as String,
      question: map['question'] as String,
      messageId: map['messageId'] as String,
      answerState: map['answerState'] as AnswerState,
    );
  }
}
