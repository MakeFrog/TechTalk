// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_qna_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatQnaModel _$ChatQnaModelFromJson(Map<String, dynamic> json) => ChatQnaModel(
      id: json['id'] as String,
      messageId: json['message_id'] as String?,
      state: json['state'] as String?,

    );

Map<String, dynamic> _$ChatQnaModelToJson(ChatQnaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message_id': instance.messageId,
      'state': instance.state,
      'follow_up_qnas': instance.followUpQnas,
    };
