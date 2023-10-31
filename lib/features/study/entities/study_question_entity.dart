import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/features/study/data/models/study_question_model.dart';

part 'study_question_entity.freezed.dart';
part 'study_question_entity.g.dart';

@freezed
class StudyQuestionEntity with _$StudyQuestionEntity {
  const factory StudyQuestionEntity({
    required String question,
    required List<String> answers,
  }) = _StudyQuestionEntity;

  factory StudyQuestionEntity.fromModel(StudyQuestionModel model) {
    return StudyQuestionEntity(
      question: model.question,
      answers: model.answers,
    );
  }
  factory StudyQuestionEntity.fromJson(Map<String, dynamic> json) =>
      _$StudyQuestionEntityFromJson(json);
}
