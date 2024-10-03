// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_up_qna_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowUpQnaModel _$FollowUpQnaModelFromJson(Map<String, dynamic> json) =>
    FollowUpQnaModel(
      id: json['id'] as String,
      messageId: json['message_id'] as String,
      state: json['state'] as String?,
      question: json['question'] as String,
    );

Map<String, dynamic> _$FollowUpQnaModelToJson(FollowUpQnaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message_id': instance.messageId,
      'question': instance.question,
      'state': instance.state,
    };
