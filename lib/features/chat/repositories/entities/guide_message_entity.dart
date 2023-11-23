import 'package:rxdart/subjects.dart';
import 'package:techtalk/features/chat/chat.dart';

class GuideMessageEntity extends MessageEntity {
  GuideMessageEntity(
      {required BehaviorSubject<String> message, required bool isStreamApplied})
      : super(
          type: ChatType.guide,
          message: message,
          isStreamApplied: isStreamApplied,
        );

  factory GuideMessageEntity.createStatic(String message) => GuideMessageEntity(
      message: BehaviorSubject.seeded(message)..close(),
      isStreamApplied: false);

  factory GuideMessageEntity.createStream(
          BehaviorSubject<String> streamedMessage) =>
      GuideMessageEntity(message: streamedMessage, isStreamApplied: false);
}
