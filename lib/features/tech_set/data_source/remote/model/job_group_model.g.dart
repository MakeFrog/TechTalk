// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobGroupModel _$JobGroupModelFromJson(Map<String, dynamic> json) =>
    JobGroupModel(
      name: json['name'] as String,
      koName: json['ko_name'] as String,
      id: json['id'] as String,
      youtubeContentCount: (json['youtube_content_count'] as num).toInt(),
      youtubeContentCountKo: (json['youtube_content_count_ko'] as num).toInt(),
      blogContentCount: (json['blog_content_count'] as num).toInt(),
      blogContentCountKo: (json['blog_content_count_ko'] as num).toInt(),
    );

Map<String, dynamic> _$JobGroupModelToJson(JobGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ko_name': instance.koName,
      'youtube_content_count': instance.youtubeContentCount,
      'youtube_content_count_ko': instance.youtubeContentCountKo,
      'blog_content_count': instance.blogContentCount,
      'blog_content_count_ko': instance.blogContentCountKo,
    };
