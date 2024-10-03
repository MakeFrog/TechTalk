import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data_source/remote/models/follow_up_qna_model.dart';
import 'package:techtalk/features/chat/repositories/entities/follow_up_qna_entity.dart';
import 'package:techtalk/features/topic/topic.dart';

class ChatQnaEntity {
  final QnaEntity qna; // 문답
  final AnswerChatEntity? message; // 유저 응답
  final FollowUpQnaEntity? followUpQna; // 꼬리 질문 응답

  bool get hasUserResponded => message != null;

  ChatQnaEntity({
    required this.qna,
    this.message,
    this.followUpQna,
  });

  factory ChatQnaEntity.fromQnaEntity(QnaEntity entity) => ChatQnaEntity(qna: entity);

  ChatQnaEntity copyWith({
    QnaEntity? qna,
    AnswerChatEntity? message,
    FollowUpQnaEntity? followUpQna,
  }) {
    return ChatQnaEntity(
      qna: qna ?? this.qna,
      message: message ?? this.message,
      followUpQna: followUpQna ?? this.followUpQna,
    );
  }
}
