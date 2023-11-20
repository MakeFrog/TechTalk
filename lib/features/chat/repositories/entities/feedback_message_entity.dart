import 'package:rxdart/subjects.dart';
import 'package:techtalk/features/chat/chat.dart';

class FeedbackMessageEntity extends MessageEntity {
  FeedbackMessageEntity({
    required BehaviorSubject<String> message,
    required bool isStreamApplied,
  }) : super(
          type: ChatType.feedback,
          message: message,
          isStreamApplied: isStreamApplied,
        );

  factory FeedbackMessageEntity.createStatic(
    String message,
  ) {
    return FeedbackMessageEntity(
      message: BehaviorSubject.seeded(message)..close(),
      isStreamApplied: false,
    );
  }

  factory FeedbackMessageEntity.createStreamChat(
      {required BehaviorSubject<String> messageStream}) {
    return FeedbackMessageEntity(
      message: messageStream,
      isStreamApplied: true,
    );
  }
}
