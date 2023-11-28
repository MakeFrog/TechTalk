import 'package:techtalk/features/skill/data/models/skill_list_model.dart';
import 'package:techtalk/features/skill/skill.dart';

class SkillListEntity {
  final int totalCount;
  final List<SkillEntity> skills;

//<editor-fold desc="Data Methods">
  const SkillListEntity({
    int? totalCount,
    List<SkillEntity>? skills,
  })  : totalCount = totalCount ?? 0,
        skills = skills ?? const [];

  factory SkillListEntity.fromModel(SkillListModel model) {
    return SkillListEntity(
      totalCount: model.totalCount,
      skills: model.skills.map(SkillEntity.fromModel).toList(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkillListEntity &&
          runtimeType == other.runtimeType &&
          totalCount == other.totalCount &&
          skills == other.skills);

  @override
  int get hashCode => totalCount.hashCode ^ skills.hashCode;

  @override
  String toString() {
    return 'SkillListEntity{' +
        ' totalCount: $totalCount,' +
        ' skills: $skills,' +
        '}';
  }

  SkillListEntity copyWith({
    int? totalCount,
    List<SkillEntity>? skills,
  }) {
    return SkillListEntity(
      totalCount: totalCount ?? this.totalCount,
      skills: skills ?? this.skills,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalCount': this.totalCount,
      'skills': this.skills,
    };
  }

  factory SkillListEntity.fromMap(Map<String, dynamic> map) {
    return SkillListEntity(
      totalCount: map['totalCount'] as int,
      skills: map['skills'] as List<SkillEntity>,
    );
  }

//</editor-fold>
}
