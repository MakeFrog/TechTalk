// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_qna_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewQnaModel _$InterviewQnaModelFromJson(Map<String, dynamic> json) =>
    InterviewQnaModel(
      id: json['id'] as String,
      questionId: json['question_id'] as String,
      messageId: json['message_id'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$InterviewQnaModelToJson(InterviewQnaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question_id': instance.questionId,
      'message_id': instance.messageId,
      'state': instance.state,
    };
