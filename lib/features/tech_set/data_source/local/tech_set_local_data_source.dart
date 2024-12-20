import 'package:techtalk/features/tech_set/data_source/local/boxes/tech_set_box.dart';
import 'package:techtalk/features/tech_set/repositories/enums/job.enum.dart';

abstract interface class TechSetLocalDataSource {
  /// 개발 직군 리스트 호출
  Future<List<Job>> getJobs();

  /// 스킬(Json String) 호출
  Future<Map<String, List<Map<String, String>>>> loadSkills();

  /// NEW : 스킬(Json String) 호출
  Future<Map<String, List<Map<String, String>>>> loadNewSkills();

  /// 캐싱된 스킬 리스트 호출
  Map<String, Map<String, List<Map<String, String>>>>? loadCachedSkillSet();

  /// 스킬 리스트 > 로컬에 저장
  Future<void> storeSkillSet(
      {required Map<String, Map<String, List<Map<String, String>>>> skillSet});
}
