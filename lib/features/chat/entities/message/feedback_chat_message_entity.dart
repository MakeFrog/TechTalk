import 'package:rxdart/subjects.dart';
import 'package:techtalk/features/chat/chat.dart';

class FeedbackChatMessageEntity extends ChatMessageEntity {
  FeedbackChatMessageEntity({
    super.id,
    required super.message,
    super.isStreamApplied = true,
    DateTime? timestamp,
  }) : super(
          type: ChatType.feedback,
          timestamp: timestamp ?? DateTime.now(),
        );

  factory FeedbackChatMessageEntity.createStatic({
    String? id,
    required String message,
    required DateTime timestamp,
  }) =>
      FeedbackChatMessageEntity(
        id: id,
        message: BehaviorSubject.seeded(message)..close(),
        timestamp: timestamp,
        isStreamApplied: false,
      );
}
