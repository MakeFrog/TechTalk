import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/skill/entities/skill_list_entity.dart';
import 'package:techtalk/features/skill/skill.dart';

final class SearchSkillsUseCase {
  const SearchSkillsUseCase(
    this._skillRepository,
  );

  final SkillRepository _skillRepository;

  Future<Result<SkillListEntity>> call(String keyword) async {
    return _skillRepository.getSkillsByKeyword(keyword);
  }
}
