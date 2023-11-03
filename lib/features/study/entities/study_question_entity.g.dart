// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_question_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudyQuestionEntityImpl _$$StudyQuestionEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$StudyQuestionEntityImpl(
      question: json['question'] as String,
      answers:
          (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$StudyQuestionEntityImplToJson(
        _$StudyQuestionEntityImpl instance) =>
    <String, dynamic>{
      'question': instance.question,
      'answers': instance.answers,
    };
