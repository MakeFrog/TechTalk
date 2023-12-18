import 'package:rxdart/subjects.dart';
import 'package:techtalk/features/chat/chat.dart';

class QuestionMessageEntity extends MessageEntity {
  final String qnaId;

  QuestionMessageEntity(
      {required this.qnaId,
      required BehaviorSubject<String> message,
      required DateTime timestamp,
      required bool isStreamApplied})
      : super(
          type: ChatType.askQuestion,
          message: message,
          isStreamApplied: isStreamApplied,
          timestamp: timestamp,
        );

  ///
  /// 스트림 상태 적용 X (정적)
  ///
  factory QuestionMessageEntity.createStaticChat({
    required String questionId,
    required String message,
    required DateTime timestamp,
  }) =>
      QuestionMessageEntity(
        qnaId: questionId,
        message: BehaviorSubject.seeded(message)..close(),
        timestamp: timestamp,
        isStreamApplied: false,
      );

  ///
  /// 스트림 상태 적용 X (정적)
  ///
  factory QuestionMessageEntity.createStreamedChat({
    required String questionId,
    required BehaviorSubject<String> streamedMessage,
  }) =>
      QuestionMessageEntity(
        qnaId: questionId,
        message: streamedMessage,
        timestamp: DateTime.now(),
        isStreamApplied: true,
      );
}
