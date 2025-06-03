// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) => CompanyModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      feedUrl: json['feed_url'] as String? ?? '',
      logoUrl: json['logo_url'] as String? ?? '',
      platform: json['platform'] as String? ?? '',
    );

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'feed_url': instance.feedUrl,
      'logo_url': instance.logoUrl,
      'platform': instance.platform,
    };
