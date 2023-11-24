import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';

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

  factory ChatRoomModel.fromEntity(ChatRoomEntity entity) => ChatRoomModel(
        interviewerId: entity.interviewerInfo.id,
        topicId: entity.topic.id,
        totalQuestionCount: entity.qnaProgressInfo.totalQuestionCount,
        correctAnswerCount: entity.qnaProgressInfo.correctAnswerCount,
        incorrectAnswerCount: entity.qnaProgressInfo.incorrectAnswerCount,
        chatRoomId: entity.chatRoomId,
      );
}
