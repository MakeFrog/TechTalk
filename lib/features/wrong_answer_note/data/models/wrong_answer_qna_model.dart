import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wrong_answer_qna_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class WrongAnswerQnAModel {
  WrongAnswerQnAModel({
    required this.id,
    required this.questionId,
    required this.chatRoomId,
    required this.qnaId,
  });

  final String id;
  final String questionId;
  final String chatRoomId;
  final String qnaId;

  factory WrongAnswerQnAModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      WrongAnswerQnAModel.fromJson(snapshot.data()!);

  factory WrongAnswerQnAModel.fromJson(Map<String, dynamic> json) {
    return _$WrongAnswerQnAModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WrongAnswerQnAModelToJson(this);
}
