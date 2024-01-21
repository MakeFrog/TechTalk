import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

class ChatQnaEntity {
  final String id; // 질문 Id
  final QnaEntity qna;
  final AnswerChatMessageEntity? message; // 유저 응답
  bool get hasUserResponded => message != null;

  ChatQnaEntity({
    required this.id,
    required this.qna,
    this.message,
  });

  factory ChatQnaEntity.fromQnaEntity(QnaEntity entity) =>
      ChatQnaEntity(id: entity.id, qna: entity);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatQnaEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          qna == other.qna &&
          message == other.message);

  @override
  int get hashCode => id.hashCode ^ qna.hashCode ^ message.hashCode;

  @override
  String toString() {
    return 'InterviewQnAEntity{' +
        ' id: $id,' +
        ' question: $qna,' +
        ' answer: $message,' +
        '}';
  }

  ChatQnaEntity copyWith({
    String? id,
    QnaEntity? question,
    AnswerChatMessageEntity? answer,
  }) {
    return ChatQnaEntity(
      id: id ?? this.id,
      qna: question ?? this.qna,
      message: answer ?? this.message,
    );
  }

//</editor-fold>
}
