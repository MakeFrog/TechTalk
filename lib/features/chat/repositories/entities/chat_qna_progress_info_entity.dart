import 'package:techtalk/features/chat/chat.dart';

class ChatQnaProgressInfoEntity {
  final int totalQuestionCount;
  final int correctAnswerCount;
  final int incorrectAnswerCount;

  int get completedQuestionCount => correctAnswerCount + incorrectAnswerCount;

  InterviewProgressState get progressState {
    if (totalQuestionCount > completedQuestionCount) {
      return InterviewProgressState.ongoing;
    } else if (totalQuestionCount == completedQuestionCount) {
      return InterviewProgressState.completed;
    } else if (correctAnswerCount == 0 && incorrectAnswerCount == 0) {
      return InterviewProgressState.initial;
    } else {
      throw UnimplementedError('유효하지 않은 [progressState]값 입니다.');
    }
  }

  PassOrFail get passOrFail {
    if (progressState.isCompleted) {
      if (correctAnswerCount >= incorrectAnswerCount) {
        return PassOrFail.pass;
      } else if (correctAnswerCount < incorrectAnswerCount) {
        return PassOrFail.failed;
      } else {
        throw UnimplementedError('유효하지 않은 [passOrFail]값 입니다.');
      }
    } else {
      throw UnimplementedError('진행도가 완료되지 않았습니다.');
    }
  }

  factory ChatQnaProgressInfoEntity.onInitial({
    required int totalQuestionCount,
  }) =>
      ChatQnaProgressInfoEntity(
        totalQuestionCount: totalQuestionCount,
        correctAnswerCount: 0,
        incorrectAnswerCount: 0,
      );

//<editor-fold desc="Data Methods">
  const ChatQnaProgressInfoEntity({
    required this.totalQuestionCount,
    required this.correctAnswerCount,
    required this.incorrectAnswerCount,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatQnaProgressInfoEntity &&
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

  Map<String, dynamic> toMap() {
    return {
      'totalQuestionCount': this.totalQuestionCount,
      'correctAnswerCount': this.correctAnswerCount,
      'incorrectAnswerCount': this.incorrectAnswerCount,
    };
  }

  factory ChatQnaProgressInfoEntity.fromMap(Map<String, dynamic> map) {
    return ChatQnaProgressInfoEntity(
      totalQuestionCount: map['totalQuestionCount'] as int,
      correctAnswerCount: map['correctAnswerCount'] as int,
      incorrectAnswerCount: map['incorrectAnswerCount'] as int,
    );
  }

//</editor-fold>
}
