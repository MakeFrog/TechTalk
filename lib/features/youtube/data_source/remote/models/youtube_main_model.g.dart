// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_main_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YoutubeMainModel _$YoutubeMainModelFromJson(Map<String, dynamic> json) =>
    YoutubeMainModel(
      id: json['id'] as String,
      title: json['title'] as String,
      thumbnailImgUrl: json['thumbnail_img_url'] as String,
      videoDuration:
          Duration(microseconds: (json['video_duration'] as num).toInt()),
      qnaNum: (json['qna_num'] as num).toInt(),
      channel: json['channel'] == null
          ? null
          : ChannelModel.fromJson(json['channel'] as Map<String, dynamic>),
      uploaderId: json['uploader_id'] as String,
      relatedSkillIds: (json['related_skill_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      relatedJobGroupIds: (json['related_job_group_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      uploadAt:
          const TimeStampConverter().fromJson(json['upload_at'] as Timestamp),
      videoPublishedDate: const TimeStampConverter()
          .fromJson(json['video_published_date'] as Timestamp),
      uploadLanguageCode: json['upload_language_code'] as String,
    );

Map<String, dynamic> _$YoutubeMainModelToJson(YoutubeMainModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'thumbnail_img_url': instance.thumbnailImgUrl,
      'title': instance.title,
      'video_duration': instance.videoDuration.inMicroseconds,
      'qna_num': instance.qnaNum,
      'related_skill_ids': instance.relatedSkillIds,
      'related_job_group_ids': instance.relatedJobGroupIds,
      'video_published_date':
          const TimeStampConverter().toJson(instance.videoPublishedDate),
      'upload_at': const TimeStampConverter().toJson(instance.uploadAt),
      'channel': instance.channel?.toJson(),
      'upload_language_code': instance.uploadLanguageCode,
      'uploader_id': instance.uploaderId,
    };
