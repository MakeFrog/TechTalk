// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_question_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudyQuestionListEntityImpl _$$StudyQuestionListEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$StudyQuestionListEntityImpl(
      questionList: (json['questionList'] as List<dynamic>)
          .map((e) => StudyQuestionEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$StudyQuestionListEntityImplToJson(
        _$StudyQuestionListEntityImpl instance) =>
    <String, dynamic>{
      'questionList': instance.questionList,
    };
