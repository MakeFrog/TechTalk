// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JobGroupModelImpl _$$JobGroupModelImplFromJson(Map<String, dynamic> json) =>
    _$JobGroupModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$JobGroupModelImplToJson(_$JobGroupModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$JobGroupListModelImpl _$$JobGroupListModelImplFromJson(
        Map<String, dynamic> json) =>
    _$JobGroupListModelImpl(
      groups: (json['groups'] as List<dynamic>)
          .map((e) => JobGroupModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$JobGroupListModelImplToJson(
        _$JobGroupListModelImpl instance) =>
    <String, dynamic>{
      'groups': instance.groups,
    };
