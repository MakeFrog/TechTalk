import 'package:techtalk/features/tech_set/data/models/job_model.dart';

abstract interface class TechSetLocalDataSource {
  Future<List<Job>> getJobs();

  /// 스킬(Json String) 호출
  Future<Map<String, List<Map<String, String>>>> loadSkills();
}
