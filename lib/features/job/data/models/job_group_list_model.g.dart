// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_group_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobGroupListModel _$JobGroupListModelFromJson(Map<String, dynamic> json) =>
    JobGroupListModel(
      totalCount: json['total_count'] as int,
      groups: (json['groups'] as List<dynamic>)
          .map((e) => $enumDecode(_$JobGroupModelEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$JobGroupListModelToJson(JobGroupListModel instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'groups': instance.groups.map((e) => _$JobGroupModelEnumMap[e]!).toList(),
    };

const _$JobGroupModelEnumMap = {
  JobGroupModel.frondEndDev: 'frondEndDev',
  JobGroupModel.backEndDev: 'backEndDev',
  JobGroupModel.serverDev: 'serverDev',
  JobGroupModel.fullStackDev: 'fullStackDev',
  JobGroupModel.androidDev: 'androidDev',
  JobGroupModel.iosDev: 'iosDev',
  JobGroupModel.crossPlatformDev: 'crossPlatformDev',
  JobGroupModel.gameClientDev: 'gameClientDev',
  JobGroupModel.gameServerDev: 'gameServerDev',
};
