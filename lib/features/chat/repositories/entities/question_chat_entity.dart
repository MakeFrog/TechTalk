import 'package:rxdart/subjects.dart';
import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/features/chat/chat.dart';

class QuestionChatEntity extends BaseChatEntity {
  final String qnaId;

  QuestionChatEntity({
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
  factory QuestionChatEntity.createStatic({
    String? id,
    required String qnaId,
    required String message,
    required DateTime timestamp,
  }) =>
      QuestionChatEntity(
        id: id,
        qnaId: qnaId,
        message: BehaviorSubject.seeded(message)..close(),
        timestamp: timestamp,
        isStreamApplied: false,
      );

  QuestionChatEntity overwriteToStream() {
    return QuestionChatEntity(
      id: id,
      message: message.value.convertToStreamText,
      timestamp: timestamp,
      isStreamApplied: true,
      qnaId: qnaId,
    );
  }
}
