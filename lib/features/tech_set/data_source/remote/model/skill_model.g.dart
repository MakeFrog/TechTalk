// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillModel _$SkillModelFromJson(Map<String, dynamic> json) {
  return SkillModel(
    name: json['name'] as String,
    koName: json['ko_name'] as String,
    category: json['category'] as String,
    youtubeContentCount: (json['youtube_content_count'] as num).toInt(),
  );
}

Map<String, dynamic> _$SkillModelToJson(SkillModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'ko_name': instance.koName,
      'category': instance.category,
      'youtube_content_count': instance.youtubeContentCount,
    };
