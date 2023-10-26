import 'package:techtalk/features/tech_skill/data/models/tech_skill_model.dart';

abstract interface class TechSkillRemoteDataSource {
  Future<List<TechSkillModel>> searchTechSkillList(String keyword);
}
