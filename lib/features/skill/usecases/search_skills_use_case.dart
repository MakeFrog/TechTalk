import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/skill/entities/skill_list_entity.dart';
import 'package:techtalk/features/skill/skill.dart';

final class SearchSkillsUseCase {
  const SearchSkillsUseCase(
    this._skillRepository,
  );

  final SkillRepository _skillRepository;

  Future<SkillListEntity> call(String keyword) async {
    final result = await _skillRepository.getSkillsByKeyword(keyword);
    return result.fold(
      onSuccess: (value) => value,
      onFailure: (e) {
        throw e;
      },
    );
  }
}
