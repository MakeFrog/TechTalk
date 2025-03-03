import 'package:techtalk/features/tech_set/data_source/remote/job_group_ref.dart';
import 'package:techtalk/features/tech_set/data_source/remote/model/job_group_model.dart';
import 'package:techtalk/features/tech_set/data_source/remote/model/skill_model.dart';
import 'package:techtalk/features/tech_set/data_source/remote/skill_ref.dart';
import 'package:techtalk/features/tech_set/data_source/remote/tech_set_remote_data_source.dart';

final class TechSetRemoteDataSourceIml implements TechSetRemoteDataSource {
  @override
  Future<List<SkillModel>> getSkills() async {
    final snapshots = await FirestoreSkillRef.collection().get();

    return snapshots.docs.map((e) => e.data()).toList();
  }

  @override
  Future<List<JobGroupModel>> getJobGroups() async {
    final snapshots = await FirestoreJobGroupRef.collection().get();

    return snapshots.docs.map((e) => e.data()).toList();
  }
}
