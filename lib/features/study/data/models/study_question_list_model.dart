import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/study/data/models/study_question_model.dart';

part 'study_question_list_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
  createToJson: false,
)
class StudyQuestionListModel {
  StudyQuestionListModel({
    required this.questionList,
  });

  final List<StudyQuestionModel> questionList;

  factory StudyQuestionListModel.fromJson(Map<String, dynamic> json) {
    return _$StudyQuestionListModelFromJson(json);
  }
}
