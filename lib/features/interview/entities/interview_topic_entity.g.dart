// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_topic_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InterviewTopicEntityImpl _$$InterviewTopicEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$InterviewTopicEntityImpl(
      name: json['name'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$InterviewTopicEntityImplToJson(
        _$InterviewTopicEntityImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'category': instance.category,
      'imageUrl': instance.imageUrl,
    };
