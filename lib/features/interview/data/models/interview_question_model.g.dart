// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewQuestionModel _$InterviewQuestionModelFromJson(
        Map<String, dynamic> json) =>
    InterviewQuestionModel(
      id: json['id'] as String,
      question: json['question'] as String,
      answers:
          (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
      updateDate: DateTime.parse(json['update_date'] as String),
    );

Map<String, dynamic> _$InterviewQuestionModelToJson(
        InterviewQuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answers': instance.answers,
      'update_date': instance.updateDate.toIso8601String(),
    };
