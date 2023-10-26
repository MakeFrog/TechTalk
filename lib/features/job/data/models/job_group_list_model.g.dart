// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_group_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
