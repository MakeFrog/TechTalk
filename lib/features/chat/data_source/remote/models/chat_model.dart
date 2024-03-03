import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/core/modules/converter/time_stamp_converter.dart';
import 'package:techtalk/features/chat/chat.dart';

part 'chat_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
  includeIfNull: false,
)
class ChatModel {
  ChatModel({
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

  factory ChatModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      ChatModel.fromJson(snapshot.data()!);

  factory ChatModel.fromEntity(BaseChatEntity entity) {
    String? qnaId;
    String? state;
    if (entity is AnswerChatEntity) {
      qnaId = entity.qnaId;
      state = entity.answerState.tag;
    }

    if (entity is QuestionChatEntity) {
      qnaId = entity.qnaId;
    }

    return ChatModel(
      id: entity.id,
      message: entity.message.value,
      type: entity.type.name,
      qnaId: qnaId,
      state: state,
      timestamp: entity.timestamp,
    );
  }

  BaseChatEntity toEntity() {
    final chatType = ChatType.getTypeById(type);
    switch (chatType) {
      case ChatType.guide:
        return GuideChatEntity.createStatic(
          id: id,
          message: message,
          timestamp: timestamp,
        );
      case ChatType.reply:
        return AnswerChatEntity(
          id: id,
          message: message,
          answerState: AnswerState.getStateById(state!),
          qnaId: qnaId!,
          timestamp: timestamp,
        );
      case ChatType.question:
        return QuestionChatEntity.createStatic(
          id: id,
          qnaId: qnaId!,
          message: message,
          timestamp: timestamp,
        );
      case ChatType.feedback:
        return FeedbackChatEntity.createStatic(
          id: id,
          message: message,
          timestamp: timestamp,
        );

      default:
        throw Exception('Unexpected type id value');
    }
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return _$ChatModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
