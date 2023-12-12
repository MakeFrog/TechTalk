// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewTopicModel _$InterviewTopicModelFromJson(Map<String, dynamic> json) =>
    InterviewTopicModel(
      id: json['id'] as String,
      text: json['text'] as String,
      imageUrl: json['image_url'] as String?,
      category: InterviewTopicCategoryModel.fromJson(
          json['category'] as Map<String, dynamic>),
      isAvailable: json['is_available'] as bool,
    );

Map<String, dynamic> _$InterviewTopicModelToJson(
        InterviewTopicModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'image_url': instance.imageUrl,
      'category': instance.category.toJson(),
      'is_available': instance.isAvailable,
    };
