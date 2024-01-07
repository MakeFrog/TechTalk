import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/core/constants/interview_type.enum.dart';
import 'package:techtalk/features/chat/chat.dart';

part 'chat_room_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ChatRoomModel {
  ChatRoomModel({
    required this.id,
    required this.interviewerId,
    required this.topicIds,
    required this.type,
    required this.totalQuestionCount,
    required this.correctAnswerCount,
    required this.incorrectAnswerCount,
  });

  final String id;
  final String interviewerId;
  final List<String> topicIds;
  final InterviewType type;
  final int totalQuestionCount;
  final int correctAnswerCount;
  final int incorrectAnswerCount;

  factory ChatRoomModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      ChatRoomModel.fromJson(snapshot.data()!);

  factory ChatRoomModel.fromEntity(ChatRoomEntity entity) => ChatRoomModel(
        id: entity.id,
        interviewerId: entity.interviewer.id,
        topicIds: entity.topics.map((e) => e.id).toList(),
        type: entity.type,
        totalQuestionCount: entity.progressInfo.totalQuestionCount,
        correctAnswerCount: entity.progressInfo.correctAnswerCount,
        incorrectAnswerCount: entity.progressInfo.incorrectAnswerCount,
      );

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return _$ChatRoomModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChatRoomModelToJson(this);
}
