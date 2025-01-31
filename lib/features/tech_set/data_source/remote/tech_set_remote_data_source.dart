import 'package:techtalk/features/tech_set/data_source/remote/model/job_group_model.dart';
import 'package:techtalk/features/tech_set/data_source/remote/model/skill_model.dart';

abstract class TechSetRemoteDataSource {
  /// 스킬 항목 리스트 호출
  Future<List<SkillModel>> getSkills();

  /// 직군 리스트 호출
  Future<List<JobGroupModel>> getJobGroups();
}
