// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_contents_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YoutubeContentsDetailModel _$YoutubeContentsDetailModelFromJson(
        Map<String, dynamic> json) =>
    YoutubeContentsDetailModel(
      id: json['id'] as String,
      title: json['title'] as String,
      authorId: json['author_id'] as String,
      relatedSkills: (json['related_skills'] as List<dynamic>)
          .map((e) => SkillModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      relatedJobGroupIds: (json['related_job_group_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      contentsLanguageIds: (json['contents_language_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      summary: SummaryModel.fromJson(json['summary'] as Map<String, dynamic>),
      uploadUserId: json['upload_user_id'] as String?,
    );

Map<String, dynamic> _$YoutubeContentsDetailModelToJson(
        YoutubeContentsDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author_id': instance.authorId,
      'related_skills': instance.relatedSkills.map((e) => e.toJson()).toList(),
      'related_job_group_ids': instance.relatedJobGroupIds,
      'contents_language_ids': instance.contentsLanguageIds,
      'summary': instance.summary.toJson(),
      'upload_user_id': instance.uploadUserId,
    };
