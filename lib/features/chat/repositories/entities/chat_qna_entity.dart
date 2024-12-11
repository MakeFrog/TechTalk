import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data_source/remote/models/follow_up_qna_model.dart';
import 'package:techtalk/features/chat/repositories/entities/base_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/follow_up_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/resume_qna_entity.dart';
import 'package:techtalk/features/topic/topic.dart';

class ChatQnaEntity {
  final BaseQnaEntity qna; // 문답
  final AnswerChatEntity? message; // 유저 응답
  final FollowUpQnaEntity? followUpQna; // 꼬리 질문 응답

  final String? question;
  final String? evaluationPoint;

  bool get hasUserResponded => message != null;

  ChatQnaEntity({
    required this.qna,
    this.message,
    this.followUpQna,
    this.question,
    this.evaluationPoint,
  });

  factory ChatQnaEntity.fromCommonQnaEntity(CommonQnaEntity entity) =>
      ChatQnaEntity(qna: entity);

  factory ChatQnaEntity.fromResumeQnaEntity(ResumeQnaEntity entity) =>
      ChatQnaEntity(
        qna: entity,
        question: entity.question,
        evaluationPoint: entity.evaluationPoint,
      );

  ChatQnaEntity copyWith({
    BaseQnaEntity? qna,
    AnswerChatEntity? message,
    FollowUpQnaEntity? followUpQna,
    String? question,
    String? evaluationPoint,
  }) {
    return ChatQnaEntity(
      qna: qna ?? this.qna,
      message: message ?? this.message,
      followUpQna: followUpQna ?? this.followUpQna,
      question: question ?? this.question,
      evaluationPoint: evaluationPoint ?? this.evaluationPoint,
    );
  }
}
