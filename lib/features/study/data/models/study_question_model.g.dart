// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudyQuestionModel _$StudyQuestionModelFromJson(Map<String, dynamic> json) =>
    StudyQuestionModel(
      question: json['question'] as String,
      answers:
          (json['answers'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
