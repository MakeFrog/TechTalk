import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/interview/entities/interview_question_entity.dart';

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

  InterviewQuestionEntity toEntity() {
    return InterviewQuestionEntity(
      id: id,
      question: question,
      answers: answers,
    );
  }

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

  factory InterviewQuestionModel.fromJson(Map<String, dynamic> json) {
    return _$InterviewQuestionModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InterviewQuestionModelToJson(this);
}