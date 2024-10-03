import 'package:rxdart/subjects.dart';
import 'package:techtalk/features/chat/chat.dart';

class FeedbackChatEntity extends BaseChatEntity {
  final String qnaId;
  final bool hasFollowUpQuestion;

  FeedbackChatEntity({
    super.id,
    required super.message,
    this.hasFollowUpQuestion = false,
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
    String? rootQnaId,
    required String qnaId,
    bool? hasFollowUpQuestion,
  }) =>
      FeedbackChatEntity(
        id: id,
        qnaId: qnaId,
        hasFollowUpQuestion: hasFollowUpQuestion ?? false,
        message: BehaviorSubject.seeded(message)..close(),
        timestamp: timestamp,
        isStreamApplied: false,
        rootQnaId: rootQnaId ?? qnaId,
      );
}
