class WrongAnswerQuestionEntity {
  final String id;
  final String question;

//<editor-fold desc="Data Methods">
  const WrongAnswerQuestionEntity({
    required this.id,
    required this.question,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WrongAnswerQuestionEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          question == other.question);

  @override
  int get hashCode => id.hashCode ^ question.hashCode;

  @override
  String toString() {
    return 'WrongAnswerQuestionEntity{' +
        ' id: $id,' +
        ' question: $question,' +
        '}';
  }

  WrongAnswerQuestionEntity copyWith({
    String? id,
    String? question,
  }) {
    return WrongAnswerQuestionEntity(
      id: id ?? this.id,
      question: question ?? this.question,
    );
  }

//</editor-fold>
}
