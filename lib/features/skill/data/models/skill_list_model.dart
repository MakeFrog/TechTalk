import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/skill/data/models/skill_model.dart';

part 'skill_list_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SkillListModel {
  SkillListModel({
    required this.totalCount,
    required this.skills,
  });

  final int totalCount;
  final List<SkillModel> skills;

  factory SkillListModel.fromJson(Map<String, dynamic> json) {
    return _$SkillListModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SkillListModelToJson(this);
}
