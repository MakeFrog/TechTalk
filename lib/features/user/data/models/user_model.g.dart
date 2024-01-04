// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] as String,
      profileImgUrl: json['profile_img_url'] as String?,
      nickname: json['nickname'] as String?,
      jobGroupIds: (json['job_group_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      topicIds: (json['topic_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'profile_img_url': instance.profileImgUrl,
      'nickname': instance.nickname,
      'job_group_ids': instance.jobGroupIds,
      'topic_ids': instance.topicIds,
    };
