import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

class ChatQnaEntity {
  final QnaEntity qna; // 문답
  final AnswerChatEntity? message; // 유저 응답
  final List<ChatQnaEntity>? followUpQuestions; // 꼬리질문들

  bool get hasUserResponded => message != null;

  ChatQnaEntity({
    required this.qna,
    this.message,
    this.followUpQuestions,
  });

  factory ChatQnaEntity.fromQnaEntity(QnaEntity entity) => ChatQnaEntity(qna: entity);

  ChatQnaEntity copyWith({
    QnaEntity? qna,
    AnswerChatEntity? message,
    List<ChatQnaEntity>? followUpQuestions,
  }) {
    return ChatQnaEntity(
      qna: qna ?? this.qna,
      message: message ?? this.message,
      followUpQuestions: followUpQuestions ?? this.followUpQuestions,
    );
  }
}
