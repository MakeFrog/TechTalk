import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/skill/entities/skill_list_entity.dart';

abstract interface class SkillRepository {
  Future<Result<SkillListEntity>> getSkillsByKeyword(String keyword);
}
