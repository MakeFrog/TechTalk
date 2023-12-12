// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_qna_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewQnaModel _$InterviewQnaModelFromJson(Map<String, dynamic> json) =>
    InterviewQnaModel(
      questionId: json['question_id'] as String,
      answer: json['answer'] as String,
      answerState: json['answer_state'] as String,
    );

Map<String, dynamic> _$InterviewQnaModelToJson(InterviewQnaModel instance) =>
    <String, dynamic>{
      'question_id': instance.questionId,
      'answer': instance.answer,
      'answer_state': instance.answerState,
    };
