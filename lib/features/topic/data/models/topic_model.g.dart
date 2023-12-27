// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicModel _$TopicModelFromJson(Map<String, dynamic> json) => TopicModel(
      id: json['id'] as String,
      categoryId: json['category_id'] as String,
      name: json['name'] as String,
      imagePath: json['image_path'] as String?,
      isAvailable: json['is_available'] as bool,
      updatedAt:
          const TimeStampConverter().fromJson(json['updated_at'] as Timestamp),
    );

Map<String, dynamic> _$TopicModelToJson(TopicModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_id': instance.categoryId,
      'name': instance.name,
      'image_path': instance.imagePath,
      'is_available': instance.isAvailable,
      'updated_at': const TimeStampConverter().toJson(instance.updatedAt),
    };
