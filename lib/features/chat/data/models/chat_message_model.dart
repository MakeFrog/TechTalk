import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/core/utils/time_stamp_converter.dart';
import 'package:techtalk/features/chat/chat.dart';

part 'chat_message_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
  includeIfNull: false,
)
class ChatMessageModel {
  ChatMessageModel({
    required this.id,
    required this.message,
    required this.type,
    this.qnaId,
    this.state,
    required this.timestamp,
  });

  final String id;
  final String message;
  final String type;
  final String? qnaId;
  final String? state;
  @TimeStampConverter()
  final DateTime timestamp;

  factory ChatMessageModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      ChatMessageModel.fromJson(snapshot.data()!);

  factory ChatMessageModel.fromEntity(ChatMessageEntity entity) {
    String? qnaId;
    String? state;
    if (entity is AnswerChatMessageEntity) {
      qnaId = entity.qnaId;
      state = entity.answerState.tag;
    }

    if (entity is QuestionChatMessageEntity) {
      qnaId = entity.qnaId;
    }

    return ChatMessageModel(
      id: entity.id,
      message: entity.message.value,
      type: entity.type.name,
      qnaId: qnaId,
      state: state,
      timestamp: entity.timestamp,
    );
  }

  ChatMessageEntity toEntity() {
    final chatType = ChatType.getTypeById(type);
    switch (chatType) {
      case ChatType.guide:
        return GuideChatMessageEntity.createStatic(
          id: id,
          message: message,
          timestamp: timestamp,
        );
      case ChatType.reply:
        return AnswerChatMessageEntity(
          id: id,
          message: message,
          answerState: AnswerState.getStateById(state!),
          qnaId: qnaId!,
          timestamp: timestamp,
        );
      case ChatType.question:
        return QuestionChatMessageEntity.createStatic(
          id: id,
          qnaId: qnaId!,
          message: message,
          timestamp: timestamp,
        );
      case ChatType.feedback:
        return FeedbackChatMessageEntity.createStatic(
          id: id,
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
