import 'package:cloud_firestore/cloud_firestore.dart';
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
    required this.updateDate,
    List<StudyQuestionModel>? questions,
  }) : questions = questions ?? [];

  final DateTime updateDate;
  final List<StudyQuestionModel> questions;

  factory StudyQuestionListModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;

    return StudyQuestionListModel(
      updateDate: (data['update_date'] as Timestamp).toDate(),
      questions: (data['questions'] as List?)
          ?.map((e) => StudyQuestionModel.fromJson(e))
          .toList(),
    );
  }

  factory StudyQuestionListModel.fromJson(Map<String, dynamic> json) {
    return _$StudyQuestionListModelFromJson(json);
  }
}
