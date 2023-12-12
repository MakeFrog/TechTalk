import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/interview_new/interview.dart';

part 'interview_message_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class InterviewMessageModel {
  InterviewMessageModel({
    required this.id,
    required this.message,
    required this.type,
    this.questionId,
    this.answerState,
    required this.timestamp,
  });

  final String id;
  final String message;
  final String type;
  final String? questionId;
  final String? answerState;
  final DateTime timestamp;

  factory InterviewMessageModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;

    return InterviewMessageModel(
      id: data['id'] as String,
      message: data['message'] as String,
      type: data['type'] as String,
      questionId: data['question_id'] as String?,
      answerState: data['answer_state'] as String?,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  factory InterviewMessageModel.fromEntity(InterviewMessageEntity message) {
    return InterviewMessageModel(
      id: message.id,
      message: message.message.value,
      type: message.type.id,
      questionId: switch (message) {
        QuestionMessageEntity(:final questionId) ||
        SentMessageEntity(:final questionId) =>
          questionId,
        _ => null,
      },
      answerState:
          message is SentMessageEntity ? message.answerState.tag : null,
      timestamp: message.timestamp,
    );
  }

  InterviewMessageEntity toEntity() {
    final chatType = ChatType.getTypeById(type);

    return switch (chatType) {
      ChatType.guide => GuideMessageEntity.createStatic(
          message: message,
          timestamp: timestamp,
        ),
      ChatType.userReply => SentMessageEntity(
          message: message,
          answerState: AnswerState.getStateById(answerState!),
          timestamp: timestamp,
          questionId: questionId!,
        ),
      ChatType.askQuestion => QuestionMessageEntity.createStaticChat(
          questionId: questionId!,
          timestamp: timestamp,
          idealAnswers: [],
          message: message,
        ),
      ChatType.feedback => FeedbackMessageEntity.createStatic(
          message: message,
          timestamp: timestamp,
        ),
    };
  }

  factory InterviewMessageModel.fromJson(Map<String, dynamic> json) {
    return _$InterviewMessageModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InterviewMessageModelToJson(this);
}
