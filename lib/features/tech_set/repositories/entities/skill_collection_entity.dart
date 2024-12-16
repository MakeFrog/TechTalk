import 'package:techtalk/features/tech_set/repositories/entities/skill_entity.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skill_set_entity.dart';

class SkillCollectionEntity {
  final String firstLetter;
  final List<SkillSetEntity> items;

  SkillCollectionEntity({required this.firstLetter, required this.items});
}
