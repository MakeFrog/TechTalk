import 'package:rxdart/subjects.dart';
import 'package:techtalk/features/interview_new/interview.dart';

class FeedbackMessageEntity extends InterviewMessageEntity {
  FeedbackMessageEntity({
    required BehaviorSubject<String> message,
    required bool isStreamApplied,
    required DateTime timestamp,
  }) : super(
          type: ChatType.feedback,
          message: message,
          isStreamApplied: isStreamApplied,
          timestamp: timestamp,
        );

  factory FeedbackMessageEntity.createStatic(
      {required String message, required DateTime timestamp}) {
    return FeedbackMessageEntity(
      message: BehaviorSubject.seeded(message)..close(),
      timestamp: timestamp,
      isStreamApplied: false,
    );
  }

  factory FeedbackMessageEntity.createStreamChat({
    required BehaviorSubject<String> messageStream,
  }) {
    return FeedbackMessageEntity(
      message: messageStream,
      timestamp: DateTime.now().add(const Duration(milliseconds: 500)),
      isStreamApplied: true,
    );
  }
}
