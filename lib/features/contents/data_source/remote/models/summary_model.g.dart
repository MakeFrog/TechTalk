// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryModel _$SummaryModelFromJson(Map<String, dynamic> json) => SummaryModel(
      mainTheme: (json['main_theme'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      summaries: (json['summaries'] as List<dynamic>)
          .map((e) => ParagraphModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SummaryModelToJson(SummaryModel instance) =>
    <String, dynamic>{
      'main_theme': instance.mainTheme,
      'summaries': instance.summaries.map((e) => e.toJson()).toList(),
    };
