import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';

abstract interface class TechSetLocalDataSource {
  /// 개발 직군 리스트 호출
  Future<List<JobGroupEntity>> getJobs();

  /// 캐싱된 스킬 리스트 호출
  Map<String, Map<String, List<Map<String, String>>>>? loadCachedSkillSet();

  /// 스킬 리스트 > 로컬에 저장
  Future<void> storeSkillSet(
      {required Map<String, Map<String, List<Map<String, String>>>> skillSet});
}
