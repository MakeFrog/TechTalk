import 'package:techtalk/features/tech_set/repositories/entities/skill_entity.dart';

class SkillCollectionEntity {
  final String firstLetter;
  final List<SkillEntity> items;

  SkillCollectionEntity({required this.firstLetter, required this.items});
}
