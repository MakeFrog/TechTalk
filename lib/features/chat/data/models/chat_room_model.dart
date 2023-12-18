import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_qna_progress_info_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/interviewer_avatar.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'chat_room_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ChatRoomModel {
  ChatRoomModel({
    required this.interviewerId,
    required this.topicId,
    required this.totalQuestionCount,
    required this.correctAnswerCount,
    required this.incorrectAnswerCount,
    required this.chatRoomId,
  });

  final String interviewerId;
  final String topicId;
  final int totalQuestionCount;
  final int correctAnswerCount;
  final int incorrectAnswerCount;
  final String chatRoomId;

  factory ChatRoomModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) =>
      ChatRoomModel.fromJson(snapshot.data()!);

  factory ChatRoomModel.fromEntity(ChatRoomEntity entity) => ChatRoomModel(
        interviewerId: entity.interviewerInfo.id,
        topicId: entity.topic.id,
        totalQuestionCount: entity.qnaProgressInfo.totalQuestionCount,
        correctAnswerCount: entity.qnaProgressInfo.correctAnswerCount,
        incorrectAnswerCount: entity.qnaProgressInfo.incorrectAnswerCount,
        chatRoomId: entity.chatRoomId,
      );

  ChatRoomEntity toEntity() => ChatRoomEntity(
        chatRoomId: chatRoomId,
        interviewerInfo: InterviewerAvatar.getAvatarInfoById(interviewerId),
        topic: Topic.getTopicById(topicId),
        qnaProgressInfo: ChatQnaProgressInfoEntity(
          totalQuestionCount: totalQuestionCount,
          correctAnswerCount: correctAnswerCount,
          incorrectAnswerCount: incorrectAnswerCount,
        ),
      );

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return _$ChatRoomModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChatRoomModelToJson(this);
}
