class ChatProgressInfoEntity {
  final int totalQuestionCount;
  final int correctAnswerCount;
  final int incorrectAnswerCount;

  int get completedQuestionCount => correctAnswerCount + incorrectAnswerCount;

  factory ChatProgressInfoEntity.onInitial({
    required int totalQuestionCount,
  }) =>
      ChatProgressInfoEntity(
        totalQuestionCount: totalQuestionCount,
        correctAnswerCount: 0,
        incorrectAnswerCount: 0,
      );

//<editor-fold desc="Data Methods">
  const ChatProgressInfoEntity({
    required this.totalQuestionCount,
    required this.correctAnswerCount,
    required this.incorrectAnswerCount,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatProgressInfoEntity &&
          runtimeType == other.runtimeType &&
          totalQuestionCount == other.totalQuestionCount &&
          correctAnswerCount == other.correctAnswerCount &&
          incorrectAnswerCount == other.incorrectAnswerCount);

  @override
  int get hashCode =>
      totalQuestionCount.hashCode ^
      correctAnswerCount.hashCode ^
      incorrectAnswerCount.hashCode;

  @override
  String toString() {
    return 'ChatQnaProgressInfoEntity{' +
        ' totalQuestionCount: $totalQuestionCount,' +
        ' correctAnswerCount: $correctAnswerCount,' +
        ' incorrectAnswerCount: $incorrectAnswerCount,' +
        '}';
  }

  ChatProgressInfoEntity copyWith({
    int? totalQuestionCount,
    int? correctAnswerCount,
    int? incorrectAnswerCount,
  }) {
    return ChatProgressInfoEntity(
      totalQuestionCount: totalQuestionCount ?? this.totalQuestionCount,
      correctAnswerCount: correctAnswerCount ?? this.correctAnswerCount,
      incorrectAnswerCount: incorrectAnswerCount ?? this.incorrectAnswerCount,
    );
  }
}
