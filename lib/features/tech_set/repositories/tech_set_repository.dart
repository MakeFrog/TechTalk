import 'dart:async';

import 'package:techtalk/features/tech_set/repositories/entities/job_group_entity.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';

abstract interface class TechSetRepository {
  /// 개발 직군 리스트 호출
  List<JobGroupEntity> getJobs();

  /// 스킬 리스트 초기화
  Future<void> initSkills();

  /// 스킬 리스트 초기화
  Future<void> initJobGroups();

  /// id 값을 기반으로 [SkillEntity]을 리턴
  SkillEntity getSkillById(String id);

  /// id 값을 기반으로 [SkillEntity]을 리턴
  JobGroupEntity getJobGroupById(String id);

  /// 스킬 리스트 호출
  List<SkillEntity> getSkills();
}
