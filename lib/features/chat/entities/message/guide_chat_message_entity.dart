import 'package:rxdart/subjects.dart';
import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/features/chat/chat.dart';

class GuideChatMessageEntity extends ChatMessageEntity {
  GuideChatMessageEntity({
    super.id,
    required super.message,
    super.isStreamApplied = true,
    DateTime? timestamp,
  }) : super(
          type: ChatType.guide,
          timestamp: timestamp ?? DateTime.now(),
        );

  factory GuideChatMessageEntity.createStatic({
    String? id,
    required String message,
    required DateTime timestamp,
  }) =>
      GuideChatMessageEntity(
        id: id,
        message: BehaviorSubject.seeded(message)..close(),
        isStreamApplied: false,
        timestamp: timestamp,
      );

  GuideChatMessageEntity overwriteToStream() {
    return GuideChatMessageEntity(
      id: id,
      message: message.value.convertToStreamText,
      timestamp: timestamp,
    );
  }
}
