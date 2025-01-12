import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/chat/data_source/remote/models/follow_up_qna_model.dart';
import 'package:techtalk/features/chat/data_source/remote/models/resume_field_model.dart';

part 'chat_qna_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ChatQnaModel {
  ChatQnaModel({
    required this.id,
    this.messageId,
    this.state,
    this.followUpQnas,
    this.resumeField,
  });

  final String id;
  final String? messageId;
  final String? state;
  final List<FollowUpQnaModel>? followUpQnas;

  /// 1.1.0 (이력서 면접)
  ResumeFieldModel? resumeField;

  String get topicId => id.split('-').first;

  factory ChatQnaModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      ChatQnaModel.fromJson(snapshot.data()!);

  factory ChatQnaModel.fromJson(Map<String, dynamic> json) {
    return _$ChatQnaModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChatQnaModelToJson(this);
}
