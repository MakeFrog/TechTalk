// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) =>
    UserDataModel(
      uid: json['uid'] as String,
      nickname: json['nickname'] as String?,
      jobGroupIds: (json['job_group_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      topicIds: (json['topic_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nickname': instance.nickname,
      'job_group_ids': instance.jobGroupIds,
      'topic_ids': instance.topicIds,
    };
