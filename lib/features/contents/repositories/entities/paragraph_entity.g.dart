// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paragraph_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParagraphEntity _$ParagraphEntityFromJson(Map<String, dynamic> json) =>
    ParagraphEntity(
      title: json['title'] as String,
      contents:
          (json['contents'] as List<dynamic>).map((e) => e as String).toList(),
      timestamp:
          const StringToDurationConveter().fromJson(json['offset'] as String?),
    );

Map<String, dynamic> _$ParagraphEntityToJson(ParagraphEntity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'contents': instance.contents,
      'offset': const StringToDurationConveter().toJson(instance.timestamp),
    };
