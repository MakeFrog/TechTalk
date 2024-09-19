// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      id: json['id'] as String,
      message: json['message'] as String,
      type: json['type'] as String,
      qnaId: json['qna_id'] as String?,
      state: json['state'] as String?,
      timestamp:
          const TimeStampConverter().fromJson(json['timestamp'] as Timestamp),
      rootQnaId: json['root_qna_id'] as String?,
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'message': instance.message,
    'type': instance.type,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('qna_id', instance.qnaId);
  writeNotNull('state', instance.state);
  writeNotNull('root_qna_id', instance.rootQnaId);
  val['timestamp'] = const TimeStampConverter().toJson(instance.timestamp);
  return val;
}
