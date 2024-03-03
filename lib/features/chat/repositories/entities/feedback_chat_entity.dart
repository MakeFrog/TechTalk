import 'package:rxdart/subjects.dart';
import 'package:techtalk/features/chat/chat.dart';

class FeedbackChatEntity extends BaseChatEntity {
  FeedbackChatEntity({
    super.id,
    required super.message,
    super.isStreamApplied = true,
    DateTime? timestamp,
  }) : super(
          type: ChatType.feedback,
          timestamp: timestamp ?? DateTime.now(),
        );

  factory FeedbackChatEntity.createStatic({
    String? id,
    required String message,
    required DateTime timestamp,
  }) =>
      FeedbackChatEntity(
        id: id,
        message: BehaviorSubject.seeded(message)..close(),
        timestamp: timestamp,
        isStreamApplied: false,
      );
}
