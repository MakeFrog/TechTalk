// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contents_author_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelModel _$ChannelModelFromJson(Map<String, dynamic> json) => ChannelModel(
      id: json['id'] as String,
      name: json['name'] as String,
      logoUrl: json['logo_url'] as String?,
    );

Map<String, dynamic> _$ChannelModelToJson(ChannelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo_url': instance.logoUrl,
    };
