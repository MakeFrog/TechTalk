// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioEntity _$PortfolioEntityFromJson(Map<String, dynamic> json) =>
    PortfolioEntity(
      type: json['type'] ?? DocumentType.portfolio,
      path: json['path'] as String?,
      title: json['title'] as String?,
      uploadAt: json['uploadAt'] as String?,
    );

Map<String, dynamic> _$PortfolioEntityToJson(PortfolioEntity instance) =>
    <String, dynamic>{
      'type': _$DocumentTypeEnumMap[instance.type],
      'path': instance.path,
      'title': instance.title,
      'uploadAt': instance.uploadAt,
    };

const _$DocumentTypeEnumMap = {
  DocumentType.resume: 'resume',
  DocumentType.portfolio: 'portfolio',
};
