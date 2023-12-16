class InterviewProgressInfoEntity {
  final int questionCount;
  final int correctAnswerCount;
  final int incorrectAnswerCount;

  InterviewProgressInfoEntity({
    required this.questionCount,
    required this.correctAnswerCount,
    required this.incorrectAnswerCount,
  });

  factory InterviewProgressInfoEntity.onInitial(
          {required int totalQuestionCount}) =>
      InterviewProgressInfoEntity(
        questionCount: totalQuestionCount,
        correctAnswerCount: 0,
        incorrectAnswerCount: 0,
      );

  InterviewProgressInfoEntity copyWith({
    int? totalQuestionCount,
    int? correctAnswerCount,
    int? incorrectAnswerCount,
  }) {
    return InterviewProgressInfoEntity(
      questionCount: totalQuestionCount ?? this.questionCount,
      correctAnswerCount: correctAnswerCount ?? this.correctAnswerCount,
      incorrectAnswerCount: incorrectAnswerCount ?? this.incorrectAnswerCount,
    );
  }
}
