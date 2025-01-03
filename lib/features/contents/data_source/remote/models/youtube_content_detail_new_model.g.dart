// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_content_detail_new_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YoutubeContentsDetailNewModel _$YoutubeContentsDetailNewModelFromJson(
        Map<String, dynamic> json) =>
    YoutubeContentsDetailNewModel(
      summary: SummaryModel.fromJson(json['summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$YoutubeContentsDetailNewModelToJson(
        YoutubeContentsDetailNewModel instance) =>
    <String, dynamic>{
      'summary': instance.summary.toJson(),
    };
