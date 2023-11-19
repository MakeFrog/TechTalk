import 'package:rxdart/subjects.dart';
import 'package:techtalk/features/chat/chat.dart';

class FeedbackChatEntity extends ChatEntity {
  FeedbackChatEntity({
    required BehaviorSubject<String> message,
    required bool isStreamApplied,
  }) : super(
          type: ChatType.feedback,
          message: message,
          isStreamApplied: isStreamApplied,
        );

  factory FeedbackChatEntity.createStatic(
    String message,
  ) {
    return FeedbackChatEntity(
      message: BehaviorSubject.seeded(message)..close(),
      isStreamApplied: false,
    );
  }

  factory FeedbackChatEntity.createStreamChat(
      {required BehaviorSubject<String> messageStream}) {
    return FeedbackChatEntity(
      message: messageStream,
      isStreamApplied: true,
    );
  }
}
