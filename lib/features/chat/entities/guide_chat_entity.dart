import 'package:rxdart/subjects.dart';
import 'package:techtalk/features/chat/chat.dart';

class GuideChatEntity extends ChatEntity {
  GuideChatEntity(
      {required BehaviorSubject<String> message, required bool isStreamApplied})
      : super(
          type: ChatType.guide,
          message: message,
          isStreamApplied: isStreamApplied,
        );

  factory GuideChatEntity.createStatic(String message) => GuideChatEntity(
      message: BehaviorSubject.seeded(message)..close(),
      isStreamApplied: false);

  factory GuideChatEntity.createStream(
          BehaviorSubject<String> streamedMessage) =>
      GuideChatEntity(message: streamedMessage, isStreamApplied: false);
}
