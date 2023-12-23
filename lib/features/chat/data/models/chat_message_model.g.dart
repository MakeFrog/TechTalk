// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) =>
    ChatMessageModel(
      id: json['id'] as String,
      message: json['message'] as String,
      type: json['type'] as String,
      qna: json['qna'] as Map<String, dynamic>?,
      timestamp:
          const TimeStampConverter().fromJson(json['timestamp'] as Timestamp),
    );

Map<String, dynamic> _$ChatMessageModelToJson(ChatMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'type': instance.type,
      'qna': instance.qna,
      'timestamp': const TimeStampConverter().toJson(instance.timestamp),
    };
