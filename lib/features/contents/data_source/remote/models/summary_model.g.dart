// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryModel _$SummaryModelFromJson(Map<String, dynamic> json) => SummaryModel(
      mainSummary:
          ParagraphModel.fromJson(json['main_summary'] as Map<String, dynamic>),
      additionalSummary: (json['additional_summary'] as List<dynamic>)
          .map((e) => ParagraphModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SummaryModelToJson(SummaryModel instance) =>
    <String, dynamic>{
      'main_summary': instance.mainSummary.toJson(),
      'additional_summary':
          instance.additionalSummary.map((e) => e.toJson()).toList(),
    };
