import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techtalk/features/chat/chat.dart';

@CopyWith()
class ReceivedChatEntity extends ChatEntity {
  ReceivedChatEntity(
      {required ChatType type,
      required BehaviorSubject<String> message,
      required bool isStreamApplied})
      : super(type: type, message: message, isStreamApplied: isStreamApplied);

  ///
  /// 스트림 상태 적용 X (정적)
  ///
  factory ReceivedChatEntity.createStaticChat({
    required ChatType type,
    required String message,
  }) =>
      ReceivedChatEntity(
        type: type,
        message: BehaviorSubject<String>.seeded(message)..close(),
        isStreamApplied: false,
      );

  ///
  /// 스트림 상태 적용
  ///
  factory ReceivedChatEntity.createStreamChat({
    required ChatType type,
    required BehaviorSubject<String> message,
  }) =>
      ReceivedChatEntity(
        type: type,
        message: message,
        isStreamApplied: true,
      );
}
