import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/features/study/data/models/study_question_list_model.dart';
import 'package:techtalk/features/study/entities/study_question_entity.dart';

part 'study_question_list_entity.freezed.dart';
part 'study_question_list_entity.g.dart';

@freezed
class StudyQuestionListEntity with _$StudyQuestionListEntity {
  const factory StudyQuestionListEntity({
    required List<StudyQuestionEntity> questionList,
  }) = _StudyQuestionListEntity;

  factory StudyQuestionListEntity.fromModel(StudyQuestionListModel model) {
    return StudyQuestionListEntity(
      questionList:
          model.questionList.map(StudyQuestionEntity.fromModel).toList(),
    );
  }
  factory StudyQuestionListEntity.fromJson(Map<String, dynamic> json) =>
      _$StudyQuestionListEntityFromJson(json);
}
