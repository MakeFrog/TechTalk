// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uploaded_youtube_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadedYoutubeModel _$UploadedYoutubeModelFromJson(
        Map<String, dynamic> json) =>
    UploadedYoutubeModel(
      id: json['id'] as String,
      uploadAt:
          const TimeStampConverter().fromJson(json['upload_at'] as Timestamp),
    );

Map<String, dynamic> _$UploadedYoutubeModelToJson(
        UploadedYoutubeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'upload_at': const TimeStampConverter().toJson(instance.uploadAt),
    };
