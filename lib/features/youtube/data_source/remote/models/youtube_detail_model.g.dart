// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YoutubeDetailModel _$YoutubeDetailModelFromJson(Map<String, dynamic> json) =>
    YoutubeDetailModel(
      summary: SummaryModel.fromJson(json['summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$YoutubeDetailModelToJson(YoutubeDetailModel instance) =>
    <String, dynamic>{
      'summary': instance.summary.toJson(),
    };
