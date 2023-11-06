import 'package:json_annotation/json_annotation.dart';

part 'study_question_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
  createToJson: false,
)
class StudyQuestionModel {
  StudyQuestionModel({
    required this.question,
    List<String>? answers,
  }) : answers = answers ?? [];

  final String question;
  final List<String> answers;

  factory StudyQuestionModel.fromJson(Map<String, dynamic> json) {
    return _$StudyQuestionModelFromJson(json);
  }
}
