// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataEntityImpl _$$UserDataEntityImplFromJson(Map<String, dynamic> json) =>
    _$UserDataEntityImpl(
      uid: json['uid'] as String,
      nickname: json['nickname'] as String?,
      interestedJobGroupIdList:
          (json['interestedJobGroupIdList'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              const [],
      techSkillIdList: (json['techSkillIdList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserDataEntityImplToJson(
        _$UserDataEntityImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nickname': instance.nickname,
      'interestedJobGroupIdList': instance.interestedJobGroupIdList,
      'techSkillIdList': instance.techSkillIdList,
    };
