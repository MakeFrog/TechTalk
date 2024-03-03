import 'dart:async';

import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

abstract interface class TechSetRepository {
  /// 개발 직군 리스트 호출
  List<Job> getJobs();

  /// 스킬 리스트 초기화
  Future<void> initSkills();

  /// 첫 문자에 해당하는 스킬 리스트 호출
  Result<SkillCollectionEntity> getSkillsByFirstLetter(String letter);

  /// id 값을 기반으로 [SkillEntity]을 리턴
  SkillEntity getSkillById(String id);
}
