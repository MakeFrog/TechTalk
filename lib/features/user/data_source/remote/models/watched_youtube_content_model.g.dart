// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watched_youtube_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchedYoutubeModel _$WatchedYoutubeModelFromJson(Map<String, dynamic> json) =>
    WatchedYoutubeModel(
      id: json['id'] as String,
      watchedAt:
          const TimeStampConverter().fromJson(json['watched_at'] as Timestamp),
    );

Map<String, dynamic> _$WatchedYoutubeModelToJson(
        WatchedYoutubeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'watched_at': const TimeStampConverter().toJson(instance.watchedAt),
    };
