import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/interview_new/entities/interview_room_entity.dart';

part 'interview_room_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class InterviewRoomModel {
  InterviewRoomModel({
    required this.id,
    required this.interviewerId,
    required this.topicId,
    required this.questionCount,
    required this.correctAnswerCount,
    required this.incorrectAnswerCount,
  });

  final String id;
  final String interviewerId;
  final String topicId;
  final int questionCount;
  final int correctAnswerCount;
  final int incorrectAnswerCount;

  factory InterviewRoomModel.fromEntity(InterviewRoomEntity entity) {
    return InterviewRoomModel(
      id: entity.chatRoomId,
      interviewerId: entity.interviewerInfo.id,
      topicId: entity.topic.id,
      questionCount: entity.progressInfo.questionCount,
      correctAnswerCount: entity.progressInfo.correctAnswerCount,
      incorrectAnswerCount: entity.progressInfo.incorrectAnswerCount,
    );
  }

  factory InterviewRoomModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;

    return InterviewRoomModel(
      id: data['id'] as String,
      interviewerId: data['interviewer_id'] as String,
      topicId: data['topic_id'] as String,
      questionCount: data['question_count'] as int,
      correctAnswerCount: data['correct_answer_count'] as int,
      incorrectAnswerCount: data['incorrect_answer_count'] as int,
    );
  }

  factory InterviewRoomModel.fromJson(Map<String, dynamic> json) {
    return _$InterviewRoomModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InterviewRoomModelToJson(this);
}
