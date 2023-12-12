import 'package:rxdart/subjects.dart';
import 'package:techtalk/features/interview_new/interview.dart';

class GuideMessageEntity extends InterviewMessageEntity {
  GuideMessageEntity({
    required BehaviorSubject<String> message,
    required bool isStreamApplied,
    required DateTime timestamp,
  }) : super(
          type: ChatType.guide,
          message: message,
          isStreamApplied: isStreamApplied,
          timestamp: timestamp,
        );

  factory GuideMessageEntity.createStatic(
          {required String message, required DateTime timestamp}) =>
      GuideMessageEntity(
        message: BehaviorSubject.seeded(message)..close(),
        isStreamApplied: false,
        timestamp: timestamp,
      );

  factory GuideMessageEntity.createStream(
          BehaviorSubject<String> streamedMessage) =>
      GuideMessageEntity(
        message: streamedMessage,
        isStreamApplied: true,
        timestamp: DateTime.now(),
      );
}
