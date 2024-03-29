import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';

part 'chat_qna_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ChatQnaModel {
  ChatQnaModel({
    required this.id,
    this.messageId,
    this.state,
  });

  final String id;
  final String? messageId;
  final String? state;

  String get topicId => id.split('-').first;

  factory ChatQnaModel.fromEntity(ChatQnaEntity entity) {
    return ChatQnaModel(
      id: entity.qna.id,
      messageId: entity.message?.id,
      state: entity.message?.answerState.tag,
    );
  }

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
