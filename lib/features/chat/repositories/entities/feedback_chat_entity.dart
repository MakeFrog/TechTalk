import 'package:rxdart/subjects.dart';
import 'package:techtalk/features/chat/chat.dart';

class FeedbackChatEntity extends BaseChatEntity {
  final String qnaId;

  FeedbackChatEntity({
    super.id,
    required super.message,
    super.isStreamApplied = true,
    DateTime? timestamp,
    required String rootQnaId,
    required this.qnaId,
  }) : super(
          type: ChatType.feedback,
          timestamp: timestamp ?? DateTime.now(),
          rootQnaId: rootQnaId,
        );

  factory FeedbackChatEntity.createStatic({
    String? id,
    required String message,
    required DateTime timestamp,
    required String rootQnaId,
    required String qnaId,
  }) =>
      FeedbackChatEntity(
        id: id,
        qnaId: qnaId,
        message: BehaviorSubject.seeded(message)..close(),
        timestamp: timestamp,
        isStreamApplied: false,
        rootQnaId: rootQnaId,
      );
}
