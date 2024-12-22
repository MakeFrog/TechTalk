// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contents_author_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentsAuthorModel _$ContentsAuthorModelFromJson(Map<String, dynamic> json) =>
    ContentsAuthorModel(
      id: json['id'] as String,
      name: json['name'] as String,
      profileImgUrl: json['profile_img_url'] as String?,
    );

Map<String, dynamic> _$ContentsAuthorModelToJson(
        ContentsAuthorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_img_url': instance.profileImgUrl,
    };
