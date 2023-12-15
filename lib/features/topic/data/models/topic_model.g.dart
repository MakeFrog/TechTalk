// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicModel _$TopicModelFromJson(Map<String, dynamic> json) => TopicModel(
      id: json['id'] as String,
      text: json['text'] as String,
      category:
          TopicCategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      imageUrl: json['image_url'] as String?,
      isAvailable: json['is_available'] as bool,
    );

Map<String, dynamic> _$TopicModelToJson(TopicModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'category': instance.category.toJson(),
      'image_url': instance.imageUrl,
      'is_available': instance.isAvailable,
    };
