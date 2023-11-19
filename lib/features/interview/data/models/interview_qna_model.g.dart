// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_qna_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewQnaModel _$InterviewQnaModelFromJson(Map<String, dynamic> json) =>
    InterviewQnaModel(
      id: json['id'] as String,
      question: json['question'] as String,
      answers:
          (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
      myAnswer: json['my_answer'] as String,
    );

Map<String, dynamic> _$InterviewQnaModelToJson(InterviewQnaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answers': instance.answers,
      'my_answer': instance.myAnswer,
    };
