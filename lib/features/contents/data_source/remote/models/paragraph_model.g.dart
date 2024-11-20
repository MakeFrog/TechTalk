// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paragraph_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParagraphModel _$ParagraphModelFromJson(Map<String, dynamic> json) =>
    ParagraphModel(
      title: json['title'] as String,
      contents: json['contents'] as String,
      timestamp: const DurationConverter()
          .fromJson((json['timestamp'] as num?)?.toInt()),
    );

Map<String, dynamic> _$ParagraphModelToJson(ParagraphModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'contents': instance.contents,
      'timestamp': const DurationConverter().toJson(instance.timestamp),
    };
