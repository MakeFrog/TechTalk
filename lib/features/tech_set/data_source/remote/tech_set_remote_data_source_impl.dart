import 'package:techtalk/features/tech_set/data_source/remote/model/skill_model.dart';
import 'package:techtalk/features/tech_set/data_source/remote/model/tech_set_keys_model.dart';
import 'package:techtalk/features/tech_set/data_source/remote/skill_ref.dart';
import 'package:techtalk/features/tech_set/data_source/remote/tech_set_remote_data_source.dart';

final class TechSetRemoteDataSourceIml implements TechSetRemoteDataSource {
  @override
  Future<TechSetKeysModel> getKeys() {
    // TODO: implement getKeys
    throw UnimplementedError();
  }

  @override
  Future<List<SkillModel>> getNewSkills() async {
    final snapshots = await FirestoreSkillRef.collection().get();

    return snapshots.docs.map((e) => e.data()).toList();
  }

  @override
  Future getSkills() {
    // TODO: implement getSkills
    throw UnimplementedError();
  }
}
