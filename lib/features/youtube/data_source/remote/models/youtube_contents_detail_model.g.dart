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
      relatedSkillIds: (json['related_skill_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      relatedJobGroupIds: (json['related_job_group_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      contentsLanguageIds: (json['contents_language_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      summary: SummaryModel.fromJson(json['summary'] as Map<String, dynamic>),
      createdAt:
          const TimeStampConverter().fromJson(json['created_at'] as Timestamp),
      uploadAt:
          const TimeStampConverter().fromJson(json['upload_at'] as Timestamp),
      uploadUserId: json['upload_user_id'] as String?,
    );

Map<String, dynamic> _$YoutubeContentsDetailModelToJson(
        YoutubeContentsDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author_id': instance.authorId,
      'related_skill_ids': instance.relatedSkillIds,
      'related_job_group_ids': instance.relatedJobGroupIds,
      'contents_language_ids': instance.contentsLanguageIds,
      'summary': instance.summary.toJson(),
      'upload_user_id': instance.uploadUserId,
      'upload_at': const TimeStampConverter().toJson(instance.uploadAt),
      'created_at': const TimeStampConverter().toJson(instance.createdAt),
    };
