// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String?,
      profileImgUrl: json['profile_img_url'] as String?,
      nickname: json['nickname'] as String?,
      jobGroupIds: (json['job_group_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      recordedTopicIds: (json['recorded_topic_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      techSkills: (json['tech_skills'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lastLoginDate: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['last_login_date'], const TimeStampConverter().fromJson),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'profile_img_url': instance.profileImgUrl,
      'nickname': instance.nickname,
      'job_group_ids': instance.jobGroupIds,
      'tech_skills': instance.techSkills,
      'recorded_topic_ids': instance.recordedTopicIds,
      'last_login_date':
          const TimeStampConverter().toJson(instance.lastLoginDate),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
