// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillModel _$SkillModelFromJson(Map<String, dynamic> json) => SkillModel(
      name: json['name'] as String,
      koName: json['ko_name'] as String,
      category: json['category'] as String,
      youtubeContentCount: (json['youtube_content_count'] as num).toInt(),
      youtubeContentCountKo: (json['youtube_content_count_ko'] as num).toInt(),
      blogContentCount: (json['blog_content_count'] as num).toInt(),
      blogContentCountKo: (json['blog_content_count_ko'] as num).toInt(),
    );

Map<String, dynamic> _$SkillModelToJson(SkillModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'ko_name': instance.koName,
      'category': instance.category,
      'youtube_content_count': instance.youtubeContentCount,
      'youtube_content_count_ko': instance.youtubeContentCountKo,
      'blog_content_count': instance.blogContentCount,
      'blog_content_count_ko': instance.blogContentCountKo,
    };
