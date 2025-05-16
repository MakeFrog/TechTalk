// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_main_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogMainModel _$BlogMainModelFromJson(Map<String, dynamic> json) =>
    BlogMainModel(
      id: json['id'] as String? ?? 'undefined',
      blogId: json['blog_id'] as String? ?? 'undefined',
      blogName: json['blog_name'] as String? ?? '블로그 없음',
      title: json['title'] as String? ?? '제목없음',
      description: json['description'] as String? ?? '',
      author: json['author'] as String? ?? '',
      linkUrl: json['link_url'] as String? ?? '',
      thumbnailUrl: json['thumbnail_url'] as String? ?? '',
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['created_at'], const TimeStampConverter().fromJson),
      updatedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['updated_at'], const TimeStampConverter().fromJson),
      publishDate: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['publish_date'], const TimeStampConverter().fromJson),
      isValid: json['is_valid'] as bool? ?? false,
      relatedSkillIds: (json['related_skill_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      relatedJobGroupIds: (json['related_job_group_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$BlogMainModelToJson(BlogMainModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'blog_id': instance.blogId,
      'blog_name': instance.blogName,
      'title': instance.title,
      'description': instance.description,
      'author': instance.author,
      'link_url': instance.linkUrl,
      'thumbnail_url': instance.thumbnailUrl,
      'created_at': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.createdAt, const TimeStampConverter().toJson),
      'updated_at': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.updatedAt, const TimeStampConverter().toJson),
      'publish_date': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.publishDate, const TimeStampConverter().toJson),
      'is_valid': instance.isValid,
      'related_skill_ids': instance.relatedSkillIds,
      'related_job_group_ids': instance.relatedJobGroupIds,
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
