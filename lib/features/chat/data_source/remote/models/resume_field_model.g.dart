// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_field_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResumeFieldModel _$ResumeFieldModelFromJson(Map<String, dynamic> json) =>
    ResumeFieldModel(
      question: json['question'] as String,
      evaluationPoint: json['evaluation_point'] as String,
      questionType:
          $enumDecode(_$ResumeQuestionTypeEnumMap, json['question_type']),
    );

Map<String, dynamic> _$ResumeFieldModelToJson(ResumeFieldModel instance) =>
    <String, dynamic>{
      'question': instance.question,
      'evaluation_point': instance.evaluationPoint,
      'question_type': _$ResumeQuestionTypeEnumMap[instance.questionType]!,
    };

const _$ResumeQuestionTypeEnumMap = {
  ResumeQuestionType.hardSkill: 'hardSkill',
  ResumeQuestionType.softSkill: 'softSkill',
};
