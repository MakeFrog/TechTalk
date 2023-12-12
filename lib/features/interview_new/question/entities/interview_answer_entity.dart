import 'package:techtalk/features/interview_new/interview.dart';

class InterviewAnswerEntity {
  final String id;
  final String questionId;
  final String chatId;
  final AnswerState answerState;
  final String answer;

//<editor-fold desc="Data Methods">
  const InterviewAnswerEntity({
    required this.id,
    required this.questionId,
    required this.chatId,
    required this.answerState,
    required this.answer,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InterviewAnswerEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          questionId == other.questionId &&
          chatId == other.chatId &&
          answerState == other.answerState &&
          answer == other.answer);

  @override
  int get hashCode =>
      id.hashCode ^
      questionId.hashCode ^
      chatId.hashCode ^
      answerState.hashCode ^
      answer.hashCode;

  @override
  String toString() {
    return 'InterviewAnswerEntity{' +
        ' id: $id,' +
        ' questionId: $questionId,' +
        ' chatId: $chatId,' +
        ' answerState: $answerState,' +
        ' answer: $answer,' +
        '}';
  }

  InterviewAnswerEntity copyWith({
    String? id,
    String? questionId,
    String? chatId,
    AnswerState? answerState,
    String? answer,
  }) {
    return InterviewAnswerEntity(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      chatId: chatId ?? this.chatId,
      answerState: answerState ?? this.answerState,
      answer: answer ?? this.answer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'questionId': this.questionId,
      'chatId': this.chatId,
      'answerState': this.answerState,
      'answer': this.answer,
    };
  }

  factory InterviewAnswerEntity.fromMap(Map<String, dynamic> map) {
    return InterviewAnswerEntity(
      id: map['id'] as String,
      questionId: map['questionId'] as String,
      chatId: map['chatId'] as String,
      answerState: map['answerState'] as AnswerState,
      answer: map['answer'] as String,
    );
  }

//</editor-fold>
}
