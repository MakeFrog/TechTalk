// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionModel _$VersionModelFromJson(Map<String, dynamic> json) => VersionModel(
      isSystemAvailable: json['is_system_available'] as bool,
      needUpdate: json['need_update'] as bool,
      versionCode: json['version_code'] as String,
      notification: json['notification'] as String,
    );

Map<String, dynamic> _$VersionModelToJson(VersionModel instance) =>
    <String, dynamic>{
      'is_system_available': instance.isSystemAvailable,
      'need_update': instance.needUpdate,
      'version_code': instance.versionCode,
      'notification': instance.notification,
    };
