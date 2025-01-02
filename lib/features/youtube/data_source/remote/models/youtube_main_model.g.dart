// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_main_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YoutubeMainModel _$YoutubeMainModelFromJson(Map<String, dynamic> json) =>
    YoutubeMainModel(
      id: json['id'] as String? ?? 'undefined',
      title: json['title'] as String? ?? '제목없음',
      thumbnailImgUrl: json['thumbnail_img_url'] as String? ?? 'undefined',
      videoDuration: json['video_duration'] == null
          ? Duration.zero
          : Duration(microseconds: (json['video_duration'] as num).toInt()),
      qnaNum: (json['qna_num'] as num?)?.toInt() ?? 0,
      channel: json['channel'] == null
          ? null
          : ChannelModel.fromJson(json['channel'] as Map<String, dynamic>),
      relatedSkillIds: (json['related_skill_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      relatedJobGroupIds: (json['related_job_group_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      uploadAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['upload_at'], const TimeStampConverter().fromJson),
      videoPublishedDate: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['video_published_date'], const TimeStampConverter().fromJson),
      uploadLanguageCode: json['upload_language_code'] as String? ?? 'ko',
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
      'video_published_date': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.videoPublishedDate, const TimeStampConverter().toJson),
      'upload_at': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.uploadAt, const TimeStampConverter().toJson),
      'channel': instance.channel?.toJson(),
      'upload_language_code': instance.uploadLanguageCode,
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
