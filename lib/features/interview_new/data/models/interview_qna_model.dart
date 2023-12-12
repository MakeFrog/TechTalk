import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'interview_qna_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class InterviewQnaModel {
  InterviewQnaModel({
    required this.questionId,
    required this.answer,
    required this.answerState,
  });

  final String questionId;
  final String answer;
  final String answerState;

  factory InterviewQnaModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;

    return InterviewQnaModel(
      questionId: data['questionId'] as String,
      answer: data['answer'] as String,
      answerState: data['answer_state'] as String,
    );
  }

  factory InterviewQnaModel.fromJson(Map<String, dynamic> json) {
    return _$InterviewQnaModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InterviewQnaModelToJson(this);
}
