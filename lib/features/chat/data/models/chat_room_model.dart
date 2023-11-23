import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room_model.freezed.dart';
part 'chat_room_model.g.dart';

@freezed
class ChatRoomModel with _$ChatRoomModel {
  const factory ChatRoomModel({
    required String interviewerId,
    required String topicId,
    required int totalQuestionCount,
    required int correctAnswerCount,
    required int incorrectAnswerCount,
    required String chatRoomId,
  }) = _ChatListItemModel;

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);

  factory ChatRoomModel.fromFirestore(
          DocumentSnapshot snapshot, SnapshotOptions? options) =>
      ChatRoomModel.fromJson(snapshot.data() as Map<String, dynamic>);
}
