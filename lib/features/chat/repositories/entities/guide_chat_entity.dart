import 'package:rxdart/subjects.dart';
import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/features/chat/chat.dart';

class GuideChatEntity extends BaseChatEntity {
  GuideChatEntity({
    super.id,
    required super.message,
    super.isStreamApplied = true,
    DateTime? timestamp,
  }) : super(
          type: ChatType.guide,
          timestamp: timestamp ?? DateTime.now(),
        );

  factory GuideChatEntity.createStatic({
    String? id,
    required String message,
    required DateTime timestamp,
  }) =>
      GuideChatEntity(
        id: id,
        message: BehaviorSubject.seeded(message)..close(),
        isStreamApplied: false,
        timestamp: timestamp,
      );

  GuideChatEntity overwriteToStream() {
    return GuideChatEntity(
      id: id,
      message: message.value.convertToStreamText,
      timestamp: timestamp,
    );
  }
}
