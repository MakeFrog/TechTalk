// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResumeEntity _$ResumeEntityFromJson(Map<String, dynamic> json) => ResumeEntity(
      type: json['type'] ?? DocumentType.resume,
      path: json['path'] as String?,
      title: json['title'] as String?,
      uploadAt: json['uploadAt'] as String?,
      extractedText: json['extractedText'] as String?,
    );

Map<String, dynamic> _$ResumeEntityToJson(ResumeEntity instance) =>
    <String, dynamic>{
      'type': _$DocumentTypeEnumMap[instance.type],
      'path': instance.path,
      'title': instance.title,
      'uploadAt': instance.uploadAt,
      'extractedText': instance.extractedText,
    };

const _$DocumentTypeEnumMap = {
  DocumentType.resume: 'resume',
  DocumentType.portfolio: 'portfolio',
};
