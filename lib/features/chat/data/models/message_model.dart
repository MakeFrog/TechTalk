import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/core/utils/time_stamp_converter.dart';
import 'package:techtalk/features/chat/chat.dart';

part 'message_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
  converters: [
    TimeStampConverter(),
  ],
)
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
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      MessageModel.fromJson(snapshot.data()!);

  factory MessageModel.fromEntity(MessageEntity entity) {
    Map<String, dynamic>? qna;

    if (entity.type.isSentMessage) {
      entity as SentMessageEntity;
      qna = {
        'id': entity.qnaId,
        'state': entity.answerState.tag,
      };
    }

    if (entity.type.isAskQuestionMessage) {
      entity as QuestionMessageEntity;
      qna = {
        'id': entity.qnaId,
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
          qnaId: qna!['id']!,
        );
      case ChatType.askQuestion:
        return QuestionMessageEntity.createStaticChat(
          questionId: qna!['id']!,
          timestamp: timestamp,
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
