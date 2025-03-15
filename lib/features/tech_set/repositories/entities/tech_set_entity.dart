import 'package:techtalk/features/tech_set/repositories/entities/job_group_entity.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';

abstract class TechSetEntity {
  static TechSetEntity skill<T>(SkillEntity skill) => SkillSet(skill);

  static TechSetEntity jobGroup<T>(JobGroupEntity jobGroup) =>
      JobGroupSet(jobGroup);

  String id() {
    return this is SkillSet
        ? (this as SkillSet).value.id
        : (this as JobGroupSet).value.id;
  }

  String name() {
    return this is SkillSet
        ? (this as SkillSet).value.name
        : (this as JobGroupSet).value.name;
  }

  R fold<R>({
    required R Function(SkillEntity value) skill,
    required R Function(JobGroupEntity e) jobGroup,
  }) {
    return this is SkillSet
        ? skill((this as SkillSet).value)
        : jobGroup((this as JobGroupSet).value);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TechSetEntity && other.id() == id();
  }

  @override
  int get hashCode => id().hashCode;
}

class SkillSet extends TechSetEntity {
  final SkillEntity value;

  SkillSet(this.value);
}

class JobGroupSet extends TechSetEntity {
  final JobGroupEntity value;

  JobGroupSet(this.value);
}
