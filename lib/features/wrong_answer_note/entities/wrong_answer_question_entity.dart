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

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'question': this.question,
    };
  }

  factory WrongAnswerQuestionEntity.fromMap(Map<String, dynamic> map) {
    return WrongAnswerQuestionEntity(
      id: map['id'] as String,
      question: map['question'] as String,
    );
  }

//</editor-fold>
}
