// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicModel _$TopicModelFromJson(Map<String, dynamic> json) => TopicModel(
      id: json['id'] as String? ?? '', // 기본값 할당
      categoryId: json['category_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      enName: json['en_name'] as String? ?? '',
      imagePath: json['image_path'] as String?, // nullable 유지
      skillIds: (json['skill_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      isAvailable: json['is_available'] as bool? ?? false,
      updatedAt: const TimeStampConverter().fromJson(
        json['updated_at'] as Timestamp? ?? Timestamp.now(),
      ), // 기본값 할당
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
