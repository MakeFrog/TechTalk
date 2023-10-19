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
      selectedJobGroupList: (json['selectedJobGroupList'] as List<dynamic>?)
              ?.map((e) => JobGroupModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$SignUpFormEntityImplToJson(
        _$SignUpFormEntityImpl instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'nicknameValidation': instance.nicknameValidation,
      'selectedJobGroupList': instance.selectedJobGroupList,
    };
