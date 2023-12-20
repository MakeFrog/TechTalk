class TopicQuestionEntity {
  final String id;
  final String question;
  final List<String> answers;

//<editor-fold desc="Data Methods">
  const TopicQuestionEntity({
    required this.id,
    required this.question,
    required this.answers,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TopicQuestionEntity &&
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

  TopicQuestionEntity copyWith({
    String? id,
    String? question,
    List<String>? answers,
  }) {
    return TopicQuestionEntity(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
    );
  }

//</editor-fold>
}
