import 'package:techtalk/features/interview/data/models/interview_question_model.dart';

class InterviewQuestionEntity {
  final String id;
  final String question;
  final List<String> answers;
  final DateTime updateDate;

  factory InterviewQuestionEntity.fromModel(InterviewQuestionModel model) {
    return InterviewQuestionEntity(
      id: model.id,
      question: model.question,
      answers: model.answers,
      updateDate: model.updateDate,
    );
  }

//<editor-fold desc="Data Methods">
  const InterviewQuestionEntity({
    required this.id,
    required this.question,
    required this.answers,
    required this.updateDate,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InterviewQuestionEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          question == other.question &&
          answers == other.answers &&
          updateDate == other.updateDate);

  @override
  int get hashCode =>
      id.hashCode ^ question.hashCode ^ answers.hashCode ^ updateDate.hashCode;

  @override
  String toString() {
    return 'InterviewQuestionEntity{' +
        ' id: $id,' +
        ' question: $question,' +
        ' answers: $answers,' +
        ' updateDate: $updateDate,' +
        '}';
  }

  InterviewQuestionEntity copyWith({
    String? id,
    String? question,
    List<String>? answers,
    DateTime? updateDate,
  }) {
    return InterviewQuestionEntity(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      updateDate: updateDate ?? this.updateDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'question': this.question,
      'answers': this.answers,
      'updateDate': this.updateDate,
    };
  }

  factory InterviewQuestionEntity.fromMap(Map<String, dynamic> map) {
    return InterviewQuestionEntity(
      id: map['id'] as String,
      question: map['question'] as String,
      answers: map['answers'] as List<String>,
      updateDate: map['updateDate'] as DateTime,
    );
  }

//</editor-fold>
}
