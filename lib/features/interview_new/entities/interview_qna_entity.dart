import 'package:techtalk/features/interview_new/entities/interview_question_entity.dart';
import 'package:techtalk/features/interview_new/entities/states/answer_state.enum.dart';

class InterviewQnAEntity {
  final InterviewQuestionEntity question;
  final String answer;
  final AnswerState answerState;

//<editor-fold desc="Data Methods">
  const InterviewQnAEntity({
    required this.question,
    required this.answer,
    required this.answerState,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InterviewQnAEntity &&
          runtimeType == other.runtimeType &&
          question == other.question &&
          answer == other.answer &&
          answerState == other.answerState);

  @override
  int get hashCode =>
      question.hashCode ^ answer.hashCode ^ answerState.hashCode;

  @override
  String toString() {
    return 'InterviewQnaEntity{' +
        ' question: $question,' +
        ' answer: $answer,' +
        ' answerState: $answerState,' +
        '}';
  }

  InterviewQnAEntity copyWith({
    InterviewQuestionEntity? question,
    String? answer,
    AnswerState? answerState,
  }) {
    return InterviewQnAEntity(
      question: question ?? this.question,
      answer: answer ?? this.answer,
      answerState: answerState ?? this.answerState,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': this.question,
      'answer': this.answer,
      'answerState': this.answerState,
    };
  }

  factory InterviewQnAEntity.fromMap(Map<String, dynamic> map) {
    return InterviewQnAEntity(
      question: map['question'] as InterviewQuestionEntity,
      answer: map['answer'] as String,
      answerState: map['answerState'] as AnswerState,
    );
  }

//</editor-fold>
}
