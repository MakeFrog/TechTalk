import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'skills_result_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
  includeIfNull: false,
)
@HiveType(typeId: 5)
class SkillsResultModel {
  @HiveField(0)
  final String key;
  @HiveField(1)
  final List<Map<String, List<dynamic>>> items;

  SkillsResultModel({required this.key, required this.items});

  factory SkillsResultModel.fromJson(Map<String, dynamic> json) =>
      _$SkillsResultModelFromJson(json);
}
