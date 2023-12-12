import 'package:rxdart/subjects.dart';
import 'package:techtalk/features/interview_new/interview.dart';

class QuestionMessageEntity extends InterviewMessageEntity {
  final String questionId;
  final List<String> idealAnswers;

  QuestionMessageEntity(
      {required this.questionId,
      required this.idealAnswers,
      required BehaviorSubject<String> message,
      required DateTime timestamp,
      required bool isStreamApplied})
      : super(
          type: ChatType.askQuestion,
          message: message,
          isStreamApplied: isStreamApplied,
          timestamp: timestamp,
        );

  ///
  /// 스트림 상태 적용 X (정적)
  ///
  factory QuestionMessageEntity.createStaticChat({
    required String questionId,
    required List<String> idealAnswers,
    required String message,
    required DateTime timestamp,
  }) =>
      QuestionMessageEntity(
        questionId: questionId,
        idealAnswers: idealAnswers,
        message: BehaviorSubject.seeded(message)..close(),
        timestamp: timestamp,
        isStreamApplied: false,
      );

  ///
  /// 스트림 상태 적용 X (정적)
  ///
  factory QuestionMessageEntity.createStreamedChat({
    required String questionId,
    required List<String> idealAnswers,
    required BehaviorSubject<String> streamedMessage,
  }) =>
      QuestionMessageEntity(
        questionId: questionId,
        idealAnswers: idealAnswers,
        message: streamedMessage,
        timestamp: DateTime.now(),
        isStreamApplied: true,
      );
}
