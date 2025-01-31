// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionModel _$VersionModelFromJson(Map<String, dynamic> json) => VersionModel(
      isSystemAvailable: json['is_system_available'] as bool? ?? true,
      needUpdate: json['need_update'] as bool? ?? false,
      versionCode: json['version_code'] as String? ?? '2.0.0',
      notification: json['notification'] as String? ?? '',
      ongoingAppReviewVersion:
          json['ongoing_app_review_version'] as String? ?? '2.0.0',
      youtubeGptModel: json['youtube_gpt_model'] as String? ?? 'gpt-4o',
    );

Map<String, dynamic> _$VersionModelToJson(VersionModel instance) =>
    <String, dynamic>{
      'is_system_available': instance.isSystemAvailable,
      'need_update': instance.needUpdate,
      'version_code': instance.versionCode,
      'ongoing_app_review_version': instance.ongoingAppReviewVersion,
      'youtube_gpt_model': instance.youtubeGptModel,
      'notification': instance.notification,
    };
