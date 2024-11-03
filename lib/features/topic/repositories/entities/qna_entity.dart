class QnaEntity {
  final String id;
  final String question;
  final List<String> answers;
  final String? questionInstruction;

  const QnaEntity({
    required this.id,
    required this.question,
    required this.answers,
    this.questionInstruction,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QnaEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          question == other.question &&
          answers == other.answers &&
          questionInstruction == other.questionInstruction);

  @override
  int get hashCode => id.hashCode ^ question.hashCode ^ answers.hashCode ^ questionInstruction.hashCode;

  @override
  String toString() {
    return 'InterviewQnaEntity{' + ' id: $id,' + ' question: $question,' + ' answers: $answers,' + '}';
  }

  QnaEntity copyWith({
    String? id,
    String? question,
    List<String>? answers,
    String? questionInstruction,
  }) {
    return QnaEntity(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      questionInstruction: questionInstruction ?? this.questionInstruction,
    );
  }
}
