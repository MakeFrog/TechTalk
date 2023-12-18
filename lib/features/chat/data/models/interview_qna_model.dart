import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'interview_qna_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class InterviewQnaModel {
  InterviewQnaModel({
    required this.id,
    required this.questionId,
    this.messageId,
    this.state,
  });

  final String id;
  final String questionId;
  final String? messageId;
  final String? state;

  factory InterviewQnaModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;

    return InterviewQnaModel(
      id: data['id'] as String,
      questionId: data['question_id'] as String,
      messageId: data['message_id'] as String?,
      state: data['state'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'id': id,
      'question_id': questionId,
      'message_id': messageId,
      'state': state,
    };
  }

  factory InterviewQnaModel.fromJson(Map<String, dynamic> json) {
    return _$InterviewQnaModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InterviewQnaModelToJson(this);
}
