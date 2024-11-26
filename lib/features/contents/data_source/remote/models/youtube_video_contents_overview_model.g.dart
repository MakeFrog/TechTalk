// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_video_contents_overview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YoutubeContentsOverviewModel _$YoutubeContentsOverviewModelFromJson(
        Map<String, dynamic> json) =>
    YoutubeContentsOverviewModel(
      id: json['id'] as String,
      contentsTitle: json['contents_title'] as String,
      thumbnailImgUrl: json['thumbnail_img_url'] as String,
      videoDuration:
          Duration(microseconds: (json['video_duration'] as num).toInt()),
      qnaNum: (json['qna_num'] as num).toInt(),
      relatedSkillIds: (json['related_skill_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      relatedJobGroupIds: (json['related_job_group_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      author:
          ContentsAuthorModel.fromJson(json['author'] as Map<String, dynamic>),
      uploadAt:
          const TimeStampConverter().fromJson(json['upload_at'] as Timestamp),
      createdAt:
          const TimeStampConverter().fromJson(json['created_at'] as Timestamp),
    );

Map<String, dynamic> _$YoutubeContentsOverviewModelToJson(
        YoutubeContentsOverviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'thumbnail_img_url': instance.thumbnailImgUrl,
      'contents_title': instance.contentsTitle,
      'video_duration': instance.videoDuration.inMicroseconds,
      'qna_num': instance.qnaNum,
      'related_skill_ids': instance.relatedSkillIds,
      'related_job_group_ids': instance.relatedJobGroupIds,
      'author': instance.author.toJson(),
      'created_at': const TimeStampConverter().toJson(instance.createdAt),
      'upload_at': const TimeStampConverter().toJson(instance.uploadAt),
    };
