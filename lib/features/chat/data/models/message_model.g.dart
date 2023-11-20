// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageModelImpl _$$ChatMessageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageModelImpl(
      id: json['id'] as String,
      message: json['message'] as String,
      type: json['type'] as String,
      qna: json['qna'] as Map<String, dynamic>?,
      timestamp: const TimeStampConverter().fromJson(json['timestamp']),
    );

Map<String, dynamic> _$$ChatMessageModelImplToJson(
        _$ChatMessageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'type': instance.type,
      'qna': instance.qna,
      'timestamp': const TimeStampConverter().toJson(instance.timestamp),
    };
