import 'package:rxdart/subjects.dart';
import 'package:techtalk/features/chat/chat.dart';

class FeedbackChatMessageEntity extends ChatMessageEntity {
  FeedbackChatMessageEntity({
    required BehaviorSubject<String> message,
    required bool isStreamApplied,
    required DateTime timestamp,
  }) : super(
          type: ChatType.feedback,
          message: message,
          isStreamApplied: isStreamApplied,
          timestamp: timestamp,
        );

  factory FeedbackChatMessageEntity.createStatic({
    required String message,
    required DateTime timestamp,
  }) {
    return FeedbackChatMessageEntity(
      message: BehaviorSubject.seeded(message)..close(),
      timestamp: timestamp,
      isStreamApplied: false,
    );
  }

  factory FeedbackChatMessageEntity.createStreamChat({
    required BehaviorSubject<String> messageStream,
  }) {
    return FeedbackChatMessageEntity(
      message: messageStream,
      timestamp: DateTime.now().add(const Duration(milliseconds: 500)),
      isStreamApplied: true,
    );
  }
}
