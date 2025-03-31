import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data_source/remote/models/follow_up_qna_model.dart';
import 'package:techtalk/features/chat/repositories/entities/base_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/follow_up_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/proficiency_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/resume_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/topic/topic.dart';

class ChatQnaEntity {
  final BaseQnaEntity qna; // 문답
  final AnswerChatEntity? message; // 유저 응답
  final FollowUpQnaEntity? followUpQna; // 꼬리 질문 응답

  bool get hasUserResponded => message != null;

  ChatQnaEntity({
    required this.qna,
    this.message,
    this.followUpQna,
  });

  factory ChatQnaEntity.fromQnaEntityAtInitial(CommonQnaEntity entity) =>
      ChatQnaEntity(qna: entity);

  factory ChatQnaEntity.fromResumeQnaEntityAtInitial(ResumeQnaEntity entity) =>
      ChatQnaEntity(qna: entity);

  factory ChatQnaEntity.fromYoutubeQnaEntityAtInitial(
          YoutubeQnaEntity entity) =>
      ChatQnaEntity(qna: entity);

  factory ChatQnaEntity.fromProficiencyQnaEntityAtInitial(
          ProficiencyQnaEntity entity) =>
      ChatQnaEntity(qna: entity);

  factory ChatQnaEntity.fromModelToResumeEntity(
      {required ChatQnaModel model,
      required AnswerChatEntity? answerChatEntity,
      required FollowUpQnaEntity? followUpQnaEntity}) {
    final resumeField = model.resumeField!;

    final targetQna = ResumeQnaEntity(
      question: resumeField.question,
      questionType: resumeField.questionType,
      evaluationPoint: resumeField.evaluationPoint,
      id: model.id,
    );

    return ChatQnaEntity(
      qna: targetQna,
      message: answerChatEntity,
      followUpQna: followUpQnaEntity,
    );
  }

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
    );
  }
}
