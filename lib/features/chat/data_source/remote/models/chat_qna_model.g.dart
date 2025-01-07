// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_qna_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatQnaModel _$ChatQnaModelFromJson(Map<String, dynamic> json) => ChatQnaModel(
      id: json['id'] as String,
      messageId: json['message_id'] as String?,
      state: json['state'] as String?,
      followUpQnas: (json['follow_up_qnas'] as List<dynamic>?)
          ?.map((e) => FollowUpQnaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      resumeField: json['resume_field'] == null
          ? null
          : ResumeFieldModel.fromJson(
              json['resume_field'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatQnaModelToJson(ChatQnaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message_id': instance.messageId,
      'state': instance.state,
      'follow_up_qnas': instance.followUpQnas?.map((e) => e.toJson()).toList(),
      'resume_field': instance.resumeField?.toJson(),
    };
