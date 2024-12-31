// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryEntity _$SummaryEntityFromJson(Map<String, dynamic> json) =>
    SummaryEntity(
      mainTheme: json['main_theme'] as String,
      summaries: (json['summaries'] as List<dynamic>)
          .map((e) => ParagraphEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SummaryEntityToJson(SummaryEntity instance) =>
    <String, dynamic>{
      'main_theme': instance.mainTheme,
      'summaries': instance.summaries,
    };
