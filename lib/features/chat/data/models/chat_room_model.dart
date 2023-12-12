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

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class InterviewRoomModel {
  InterviewRoomModel({
    required this.interviewerId,
    required this.topicId,
    required this.totalQuestionCount,
    required this.correctAnswerCount,
    required this.incorrectAnswerCount,
    required this.chatRoomId,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  final String interviewerId;
  final String topicId;
  final int totalQuestionCount;
  final int correctAnswerCount;
  final int incorrectAnswerCount;
  final String chatRoomId;
  final DateTime updatedAt;

  factory InterviewRoomModel.fromFirestore(
    DocumentSnapshot snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() as Map<String, dynamic>;

    return InterviewRoomModel(
      chatRoomId: data['chatRoomId'] as String,
      interviewerId: data['interviewerId'] as String,
      topicId: data['topicId'] as String,
      totalQuestionCount: data['totalQuestionCount'] as int,
      correctAnswerCount: data['correctAnswerCount'] as int,
      incorrectAnswerCount: data['incorrectAnswerCount'] as int,
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  factory InterviewRoomModel.fromEntity(ChatRoomEntity entity) =>
      InterviewRoomModel(
        interviewerId: entity.interviewerInfo.id,
        topicId: entity.topic.id,
        totalQuestionCount: entity.qnaProgressInfo.totalQuestionCount,
        correctAnswerCount: entity.qnaProgressInfo.correctAnswerCount,
        incorrectAnswerCount: entity.qnaProgressInfo.incorrectAnswerCount,
        chatRoomId: entity.chatRoomId,
      );

  factory InterviewRoomModel.fromJson(Map<String, dynamic> json) {
    return _$InterviewRoomModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InterviewRoomModelToJson(this);
}
