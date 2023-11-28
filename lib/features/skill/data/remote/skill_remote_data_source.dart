import 'package:techtalk/features/skill/data/models/skill_list_model.dart';

abstract interface class SkillRemoteDataSource {
  Future<SkillListModel> getSkillsByKeyword(String keyword);
}
