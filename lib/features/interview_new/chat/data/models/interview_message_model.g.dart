// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewMessageModel _$InterviewMessageModelFromJson(
        Map<String, dynamic> json) =>
    InterviewMessageModel(
      id: json['id'] as String,
      message: json['message'] as String,
      type: json['type'] as String,
      questionId: json['question_id'] as String?,
      answerState: json['answer_state'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$InterviewMessageModelToJson(
        InterviewMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'type': instance.type,
      'question_id': instance.questionId,
      'answer_state': instance.answerState,
      'timestamp': instance.timestamp.toIso8601String(),
    };
