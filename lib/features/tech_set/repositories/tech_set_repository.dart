import 'dart:async';

import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/tech_set/data_source/remote/model/tech_set_keys_model.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

abstract interface class TechSetRepository {
  /// 개발 직군 리스트 호출
  List<JobGroup> getJobs();

  /// 스킬 리스트 초기화
  Future<void> initSkills();

  /// id 값을 기반으로 [SkillEntity]을 리턴
  SkillEntity getSkillById(String id);

  /// 스킬 리스트 호출
  List<SkillEntity> getSkills();

  /// 각'TechSet' 데이터 캐싱 여부를 판단할 각 json section key값 호출
  Future<Result<TechSetKeysModel>> getKeys();
}
