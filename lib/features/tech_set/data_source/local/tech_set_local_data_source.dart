import 'package:techtalk/core/constants/job_group.enum.dart';

abstract interface class TechSetLocalDataSource {
  /// 개발 직군 리스트 호출
  Future<List<JobGroup>> getJobs();

  /// 스킬(Json String) 호출
  Future<Map<String, List<Map<String, String>>>> loadSkills();
}
