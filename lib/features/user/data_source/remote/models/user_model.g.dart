// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] as String,
      signUpDate: const TimeStampConverter()
          .fromJson(json['sign_up_date'] as Timestamp),
      lastLoginDate: const TimeStampConverter()
          .fromJson(json['last_login_date'] as Timestamp),
      loginCount: json['login_count'] as int?,
      locale: json['locale'] as String?,
      email: json['email'] as String?,
      profileImgUrl: json['profile_img_url'] as String?,
      nickname: json['nickname'] as String?,
      jobGroupIds: (json['job_group_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      recordedTopicIds: (json['recorded_topic_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      completedInterviewCount: json['completed_interview_count'] as int?,
      techSkills: (json['tech_skills'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'locale': instance.locale,
      'email': instance.email,
      'profile_img_url': instance.profileImgUrl,
      'nickname': instance.nickname,
      'job_group_ids': instance.jobGroupIds,
      'tech_skills': instance.techSkills,
      'recorded_topic_ids': instance.recordedTopicIds,
      'login_count': instance.loginCount,
      'completed_interview_count': instance.completedInterviewCount,
      'sign_up_date': const TimeStampConverter().toJson(instance.signUpDate),
      'last_login_date':
          const TimeStampConverter().toJson(instance.lastLoginDate),
    };
