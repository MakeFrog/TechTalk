import 'package:techtalk/features/tech_skill/entities/tech_skill_entity.dart';

abstract interface class TechSkillRepository {
  Future<List<TechSkillEntity>> searchTechSkillList(String keyword);
}
