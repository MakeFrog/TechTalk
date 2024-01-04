import 'package:rxdart/subjects.dart';
import 'package:techtalk/features/chat/chat.dart';

class QuestionChatMessageEntity extends ChatMessageEntity {
  final String qnaId;

  QuestionChatMessageEntity({
    super.id,
    required this.qnaId,
    required super.message,
    super.isStreamApplied = true,
    DateTime? timestamp,
  }) : super(
          type: ChatType.question,
          timestamp: timestamp ?? DateTime.now(),
        );

  ///
  /// 스트림 상태 적용 X (정적)
  ///
  factory QuestionChatMessageEntity.createStatic({
    String? id,
    required String qnaId,
    required String message,
    required DateTime timestamp,
  }) =>
      QuestionChatMessageEntity(
        id: id,
        qnaId: qnaId,
        message: BehaviorSubject.seeded(message)..close(),
        timestamp: timestamp,
        isStreamApplied: false,
      );
}
