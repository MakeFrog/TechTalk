// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_group_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobGroupListModel _$JobGroupListModelFromJson(Map<String, dynamic> json) =>
    JobGroupListModel(
      totalCount: json['total_count'] as int,
      groups: (json['groups'] as List<dynamic>)
          .map((e) => JobGroupModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JobGroupListModelToJson(JobGroupListModel instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'groups': instance.groups.map((e) => e.toJson()).toList(),
    };
