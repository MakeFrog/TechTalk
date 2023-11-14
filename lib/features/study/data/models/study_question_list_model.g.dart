// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_question_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudyQuestionListModel _$StudyQuestionListModelFromJson(
        Map<String, dynamic> json) =>
    StudyQuestionListModel(
      updateDate: DateTime.parse(json['update_date'] as String),
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => StudyQuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
