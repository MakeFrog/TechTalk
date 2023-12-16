import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'interview_question_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class InterviewQuestionModel {
  InterviewQuestionModel({
    required this.id,
    required this.question,
    required this.answers,
  });

  final String id;
  final String question;
  final List<String> answers;

  factory InterviewQuestionModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;

    return InterviewQuestionModel(
      id: data['id'] as String,
      question: data['question'] as String,
      answers: (data['answers'] as List).cast<String>(),
    );
  }

  Map<String, dynamic> toFirestore() => toJson();

  factory InterviewQuestionModel.fromJson(Map<String, dynamic> json) {
    return _$InterviewQuestionModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InterviewQuestionModelToJson(this);
}
