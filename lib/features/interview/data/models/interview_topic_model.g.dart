// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InterviewTopicModelImpl _$$InterviewTopicModelImplFromJson(
        Map<String, dynamic> json) =>
    _$InterviewTopicModelImpl(
      name: json['name'] as String,
      category: json['category'] as String,
      topicImageUrl: json['topicImageUrl'] as String?,
    );

Map<String, dynamic> _$$InterviewTopicModelImplToJson(
        _$InterviewTopicModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'category': instance.category,
      'topicImageUrl': instance.topicImageUrl,
    };
