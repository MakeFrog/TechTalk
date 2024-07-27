// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicModel _$TopicModelFromJson(Map<String, dynamic> json) => TopicModel(
      id: json['id'] as String,
      categoryId: json['category_id'] as String,
      name: json['name'] as String,
      enName: json['en_name'] as String,
      imagePath: json['image_path'] as String?,
      skillIds:
          (json['skill_ids'] as List<dynamic>).map((e) => e as String).toList(),
      isAvailable: json['is_available'] as bool,
      updatedAt:
          const TimeStampConverter().fromJson(json['updated_at'] as Timestamp),
    );

Map<String, dynamic> _$TopicModelToJson(TopicModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_id': instance.categoryId,
      'skill_ids': instance.skillIds,
      'name': instance.name,
      'en_name': instance.enName,
      'image_path': instance.imagePath,
      'is_available': instance.isAvailable,
      'updated_at': const TimeStampConverter().toJson(instance.updatedAt),
    };
