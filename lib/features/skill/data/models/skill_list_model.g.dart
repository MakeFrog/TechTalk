// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillListModel _$SkillListModelFromJson(Map<String, dynamic> json) =>
    SkillListModel(
      totalCount: json['total_count'] as int,
      skills: (json['skills'] as List<dynamic>)
          .map((e) => SkillModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SkillListModelToJson(SkillListModel instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'skills': instance.skills.map((e) => e.toJson()).toList(),
    };
