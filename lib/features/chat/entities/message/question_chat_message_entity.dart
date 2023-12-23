import 'package:rxdart/subjects.dart';
import 'package:techtalk/features/chat/chat.dart';

class QuestionChatMessageEntity extends ChatMessageEntity {
  final String qnaId;
  QuestionChatMessageEntity({
    required this.qnaId,
    required BehaviorSubject<String> message,
    required DateTime timestamp,
    required bool isStreamApplied,
  }) : super(
          type: ChatType.askQuestion,
          message: message,
          isStreamApplied: isStreamApplied,
          timestamp: timestamp,
        );

  ///
  /// 스트림 상태 적용 X (정적)
  ///
  factory QuestionChatMessageEntity.createStaticChat({
    required String qnaId,
    required String message,
    required DateTime timestamp,
  }) =>
      QuestionChatMessageEntity(
        qnaId: qnaId,
        message: BehaviorSubject.seeded(message)..close(),
        timestamp: timestamp,
        isStreamApplied: false,
      );

  ///
  /// 스트림 상태 적용 X (정적)
  ///
  factory QuestionChatMessageEntity.createStreamedChat({
    required String qnaId,
    required BehaviorSubject<String> streamedMessage,
  }) =>
      QuestionChatMessageEntity(
        qnaId: qnaId,
        message: streamedMessage,
        timestamp: DateTime.now(),
        isStreamApplied: true,
      );
}
