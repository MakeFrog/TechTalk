// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarked_youtube_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookmarkedYoutubeModel _$BookmarkedYoutubeModelFromJson(
        Map<String, dynamic> json) =>
    BookmarkedYoutubeModel(
      id: json['id'] as String,
      bookmarkedAt: const TimeStampConverter()
          .fromJson(json['bookmarked_at'] as Timestamp),
    );

Map<String, dynamic> _$BookmarkedYoutubeModelToJson(
        BookmarkedYoutubeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookmarked_at': const TimeStampConverter().toJson(instance.bookmarkedAt),
    };
