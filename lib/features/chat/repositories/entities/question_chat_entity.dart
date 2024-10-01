import 'package:rxdart/subjects.dart';
import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/features/chat/chat.dart';

class QuestionChatEntity extends BaseChatEntity {
  final String qnaId;

  QuestionChatEntity({
    super.id,
    required this.qnaId,
    required String rootQnaId,
    required super.message,
    super.isStreamApplied = true,
    DateTime? timestamp,
    ChatType? type,
  }) : super(
          type: type ?? ChatType.question,
          timestamp: timestamp ?? DateTime.now(),
          rootQnaId: rootQnaId,
        );

  bool get isFollowUpQuestion => qnaId != rootQnaId;

  ///
  /// 스트림 상태 적용 X (정적)
  ///
  factory QuestionChatEntity.createStatic({
    String? id,
    required String qnaId,
    required String rootQnaId,
    required String message,
    required DateTime timestamp,
  }) =>
      QuestionChatEntity(
        id: id,
        qnaId: qnaId,
        rootQnaId: rootQnaId,
        message: BehaviorSubject.seeded(message)..close(),
        timestamp: timestamp,
        isStreamApplied: false,
      );

  bool get isRootQuestion => qnaId == rootQnaId;

  QuestionChatEntity overwriteToStream() {
    return QuestionChatEntity(
      id: id,
      rootQnaId: rootQnaId ?? qnaId,
      message: message.value.convertToStreamText,
      timestamp: timestamp,
      isStreamApplied: true,
      qnaId: qnaId,
    );
  }
}
