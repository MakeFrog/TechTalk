class InterviewQuestionEntity {
  final String id;
  final String question;
  final List<String> answers;

//<editor-fold desc="Data Methods">
  const InterviewQuestionEntity({
    required this.id,
    required this.question,
    required this.answers,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InterviewQuestionEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          question == other.question &&
          answers == other.answers);

  @override
  int get hashCode => id.hashCode ^ question.hashCode ^ answers.hashCode;

  @override
  String toString() {
    return 'InterviewQuestionEntity{' +
        ' id: $id,' +
        ' question: $question,' +
        ' answers: $answers,' +
        '}';
  }

  InterviewQuestionEntity copyWith({
    String? id,
    String? question,
    List<String>? answers,
  }) {
    return InterviewQuestionEntity(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'question': this.question,
      'answers': this.answers,
    };
  }

  factory InterviewQuestionEntity.fromMap(Map<String, dynamic> map) {
    return InterviewQuestionEntity(
      id: map['id'] as String,
      question: map['question'] as String,
      answers: map['answers'] as List<String>,
    );
  }

//</editor-fold>
}
