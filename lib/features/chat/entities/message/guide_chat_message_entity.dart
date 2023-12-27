import 'package:rxdart/subjects.dart';
import 'package:techtalk/features/chat/chat.dart';

class GuideChatMessageEntity extends ChatMessageEntity {
  GuideChatMessageEntity({
    required BehaviorSubject<String> message,
    required bool isStreamApplied,
    required DateTime timestamp,
  }) : super(
          type: ChatType.guide,
          message: message,
          isStreamApplied: isStreamApplied,
          timestamp: timestamp,
        );

  factory GuideChatMessageEntity.createStatic({
    required String message,
    required DateTime timestamp,
  }) =>
      GuideChatMessageEntity(
        message: BehaviorSubject.seeded(message)..close(),
        isStreamApplied: false,
        timestamp: timestamp,
      );

  factory GuideChatMessageEntity.createStream(
    BehaviorSubject<String> streamedMessage,
  ) =>
      GuideChatMessageEntity(
        message: streamedMessage,
        isStreamApplied: true,
        timestamp: DateTime.now(),
      );
}
