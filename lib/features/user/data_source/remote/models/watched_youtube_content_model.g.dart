// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watched_youtube_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchedYoutubeContent _$WatchedYoutubeContentFromJson(
        Map<String, dynamic> json) =>
    WatchedYoutubeContent(
      info: YoutubeMainModel.fromJson(json['info'] as Map<String, dynamic>),
      watchedAt:
          const TimeStampConverter().fromJson(json['watched_at'] as Timestamp),
    );

Map<String, dynamic> _$WatchedYoutubeContentToJson(
        WatchedYoutubeContent instance) =>
    <String, dynamic>{
      'info': instance.info.toJson(),
      'watched_at': const TimeStampConverter().toJson(instance.watchedAt),
    };
