import 'package:techtalk/features/chat/chat.dart';

class ChatProgressInfoEntity {
  final int totalQuestionCount;
  final int correctAnswerCount;
  final int incorrectAnswerCount;

  int get completedQuestionCount => correctAnswerCount + incorrectAnswerCount;

  ChatProgress get progressState {
    if (totalQuestionCount > completedQuestionCount) {
      return ChatProgress.ongoing;
    } else if (totalQuestionCount == completedQuestionCount) {
      return ChatProgress.completed;
    } else if (correctAnswerCount == 0 && incorrectAnswerCount == 0) {
      return ChatProgress.initial;
    } else {
      throw UnimplementedError('유효하지 않은 [progressState]값 입니다.');
    }
  }

  ChatResult get chatResult {
    if (progressState.isCompleted) {
      if (correctAnswerCount >= incorrectAnswerCount) {
        return ChatResult.pass;
      } else if (correctAnswerCount < incorrectAnswerCount) {
        return ChatResult.failed;
      } else {
        throw UnimplementedError('유효하지 않은 [passOrFail]값 입니다.');
      }
    } else {
      throw UnimplementedError('진행도가 완료되지 않았습니다.');
    }
  }

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

//</editor-fold>
}
