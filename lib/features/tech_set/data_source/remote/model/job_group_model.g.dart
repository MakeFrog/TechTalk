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
    );

Map<String, dynamic> _$JobGroupModelToJson(JobGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ko_name': instance.koName,
      'youtube_content_count': instance.youtubeContentCount,
    };
