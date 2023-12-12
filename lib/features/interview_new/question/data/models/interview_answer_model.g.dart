// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewAnswerModel _$InterviewAnswerModelFromJson(
        Map<String, dynamic> json) =>
    InterviewAnswerModel(
      id: json['id'] as String,
      questionId: json['question_id'] as String,
      chatId: json['chat_id'] as String,
      answer: json['answer'] as String,
      answerState: json['answer_state'] as String,
    );

Map<String, dynamic> _$InterviewAnswerModelToJson(
        InterviewAnswerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question_id': instance.questionId,
      'chat_id': instance.chatId,
      'answer_state': instance.answerState,
      'answer': instance.answer,
    };
