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
      updatedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['updated_at'], const TimeStampConverter().fromJson),
    );

Map<String, dynamic> _$TopicModelToJson(TopicModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_id': instance.categoryId,
      'name': instance.name,
      'image_path': instance.imagePath,
      'is_available': instance.isAvailable,
      'updated_at': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.updatedAt, const TimeStampConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
