import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';

part 'message_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MessageModel {
  MessageModel({
    required this.id,
    required this.message,
    required this.type,
    required this.qna,
    required this.timestamp,
  });

  final String id;
  final String message;
  final String type;
  final Map<String, dynamic>? qna;
  final DateTime timestamp;

  factory MessageModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;

    return MessageModel(
      id: data['id'] as String,
      message: data['message'] as String,
      type: data['type'] as String,
      qna: data['qna'] as Map<String, dynamic>?,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'type': type,
      'qna': qna,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  factory MessageModel.fromEntity(MessageEntity entity) {
    Map<String, dynamic>? qna;

    if (entity.type.isSentMessage) {
      entity as SentMessageEntity;
      qna = {
        'questionId': entity.questionId,
        'state': entity.answerState.tag,
      };
    }

    if (entity.type.isAskQuestionMessage) {
      entity as QuestionMessageEntity;
      qna = {
        'questionId': entity.questionId,
        'idealAnswers': entity.idealAnswers,
      };
    }

    return MessageModel(
      id: entity.id,
      message: entity.message.value,
      type: entity.type.id,
      qna: qna,
      timestamp: entity.timestamp,
    );
  }

  MessageEntity toEntity() {
    final chatType = ChatType.getTypeById(type);
    switch (chatType) {
      case ChatType.guide:
        return GuideMessageEntity.createStatic(
          message: message,
          timestamp: timestamp,
        );

      case ChatType.userReply:
        return SentMessageEntity(
          message: message,
          answerState: AnswerState.getStateById(qna!['state']!),
          timestamp: timestamp,
          questionId: qna!['questionId']!,
        );
      case ChatType.askQuestion:
        return QuestionMessageEntity.createStaticChat(
          questionId: qna!['questionId']!,
          timestamp: timestamp,
          idealAnswers: List<String>.from(qna!['idealAnswers']!),
          message: message,
        );

      case ChatType.feedback:
        return FeedbackMessageEntity.createStatic(
          message: message,
          timestamp: timestamp,
        );

      default:
        throw Exception('Unexpected type id value');
    }
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return _$MessageModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
