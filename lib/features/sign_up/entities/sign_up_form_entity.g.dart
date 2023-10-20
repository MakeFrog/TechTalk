// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_form_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignUpFormEntityImpl _$$SignUpFormEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$SignUpFormEntityImpl(
      nickname: json['nickname'] as String?,
      nicknameValidation: json['nicknameValidation'] as String?,
      jobGroupList: (json['jobGroupList'] as List<dynamic>?)
              ?.map((e) => JobGroupModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      techSkillList: (json['techSkillList'] as List<dynamic>?)
              ?.map((e) => TechSkillEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$SignUpFormEntityImplToJson(
        _$SignUpFormEntityImpl instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'nicknameValidation': instance.nicknameValidation,
      'jobGroupList': instance.jobGroupList,
      'techSkillList': instance.techSkillList,
    };
