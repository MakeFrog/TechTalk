class ChatQnaProgressInfoEntity {
  final int totalQuestionCount;
  final int correctAnswerCount;
  final int incorrectAnswerCount;

  ChatQnaProgressInfoEntity({
    required this.totalQuestionCount,
    required this.correctAnswerCount,
    required this.incorrectAnswerCount,
  });

  factory ChatQnaProgressInfoEntity.onInitial(
          {required int totalQuestionCount}) =>
      ChatQnaProgressInfoEntity(
        totalQuestionCount: totalQuestionCount,
        correctAnswerCount: 0,
        incorrectAnswerCount: 0,
      );

  ChatQnaProgressInfoEntity copyWith({
    int? totalQuestionCount,
    int? correctAnswerCount,
    int? incorrectAnswerCount,
  }) {
    return ChatQnaProgressInfoEntity(
      totalQuestionCount: totalQuestionCount ?? this.totalQuestionCount,
      correctAnswerCount: correctAnswerCount ?? this.correctAnswerCount,
      incorrectAnswerCount: incorrectAnswerCount ?? this.incorrectAnswerCount,
    );
  }
}
