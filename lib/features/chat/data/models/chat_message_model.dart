import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/core/utils/time_stamp_converter.dart';
import 'package:techtalk/features/chat/chat.dart';

part 'chat_message_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class ChatMessageModel {
  ChatMessageModel({
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
  @TimeStampConverter()
  final DateTime timestamp;

  factory ChatMessageModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      ChatMessageModel.fromJson(snapshot.data()!);

  factory ChatMessageModel.fromEntity(ChatMessageEntity entity) {
    Map<String, dynamic>? qna;

    if (entity.type.isSentMessage) {
      entity as AnswerChatMessageEntity;
      qna = {
        'id': entity.qnaId,
        'state': entity.answerState.tag,
      };
    }

    if (entity.type.isAskQuestionMessage) {
      entity as QuestionChatMessageEntity;
      qna = {
        'id': entity.qnaId,
      };
    }

    return ChatMessageModel(
      id: entity.id,
      message: entity.message.value,
      type: entity.type.id,
      qna: qna,
      timestamp: entity.timestamp,
    );
  }

  ChatMessageEntity toEntity() {
    final chatType = ChatType.getTypeById(type);
    switch (chatType) {
      case ChatType.guide:
        return GuideChatMessageEntity.createStatic(
          message: message,
          timestamp: timestamp,
        );
      case ChatType.userReply:
        return AnswerChatMessageEntity(
          message: message,
          answerState: AnswerState.getStateById(qna!['state']!),
          timestamp: timestamp,
          qnaId: qna!['id']!,
        );
      case ChatType.askQuestion:
        return QuestionChatMessageEntity.createStaticChat(
          qnaId: qna!['id']!,
          timestamp: timestamp,
          message: message,
        );
      case ChatType.feedback:
        return FeedbackChatMessageEntity.createStatic(
          message: message,
          timestamp: timestamp,
        );

      default:
        throw Exception('Unexpected type id value');
    }
  }

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return _$ChatMessageModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);
}
