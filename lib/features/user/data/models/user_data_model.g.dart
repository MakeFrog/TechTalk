// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataModelImpl _$$UserDataModelImplFromJson(Map<String, dynamic> json) =>
    _$UserDataModelImpl(
      uid: json['uid'] as String,
      nickname: json['nickname'] as String?,
      jobGroupIds: (json['jobGroupIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      topicIds: (json['topicIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$UserDataModelImplToJson(_$UserDataModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nickname': instance.nickname,
      'jobGroupIds': instance.jobGroupIds,
      'topicIds': instance.topicIds,
    };
