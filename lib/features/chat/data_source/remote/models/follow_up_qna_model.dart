import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'follow_up_qna_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class FollowUpQnaModel {
  FollowUpQnaModel({
    required this.id,
    required  this.messageId,
     this.state,
    required this.question,
  });

  final String id;
  final String messageId;
  final String question;
  final String? state;

  factory FollowUpQnaModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      FollowUpQnaModel.fromJson(snapshot.data()!);

  factory FollowUpQnaModel.fromJson(Map<String, dynamic> json) {
    return _$FollowUpQnaModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FollowUpQnaModelToJson(this);
}
