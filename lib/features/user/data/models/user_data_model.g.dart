// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataModelImpl _$$UserDataModelImplFromJson(Map<String, dynamic> json) =>
    _$UserDataModelImpl(
      uid: json['uid'] as String,
      nickname: json['nickname'] as String?,
      interestedJobGroupIdList:
          (json['interestedJobGroupIdList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      techSkillIdList: (json['techSkillIdList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$UserDataModelImplToJson(_$UserDataModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nickname': instance.nickname,
      'interestedJobGroupIdList': instance.interestedJobGroupIdList,
      'techSkillIdList': instance.techSkillIdList,
    };
