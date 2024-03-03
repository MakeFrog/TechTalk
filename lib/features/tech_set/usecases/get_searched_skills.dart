import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

class GetSearchedSkills
    extends BaseNoFutureUseCase<String, Result<List<SkillEntity>>> {
  GetSearchedSkills(this.repository);

  final TechSetRepository repository;
  SkillCollectionEntity? _cachedSearchedTerm;

  @override
  Result<List<SkillEntity>> call(String searchedTerm) {
    final firstLetter = searchedTerm[0].toLowerCase();

    if (_cachedSearchedTerm != null &&
        _cachedSearchedTerm!.firstLetter == firstLetter) {
      return Result.success(
        _filterSkillsByTerm(
          skills: _cachedSearchedTerm!.items,
          searchedTerm: searchedTerm,
        ),
      );
    }

    final skills = repository.getSkillsByFirstLetter(firstLetter).getOrThrow();
    _cachedSearchedTerm = skills;

    final result =
        _filterSkillsByTerm(skills: skills.items, searchedTerm: searchedTerm);

    return Result.success(result);
  }

  ///
  /// 검색어를 기반으로 연속된 문자열을
  /// 가지고 있는 리스트를 반환
  ///
  List<SkillEntity> _filterSkillsByTerm(
      {required List<SkillEntity> skills, required String searchedTerm}) {
    final filteredTerm = searchedTerm.toLowerCase();
    final result = skills.where((e) {
      String filteredName = e.name.toLowerCase();

      return filteredName.contains(filteredTerm);
    }).toList();

    return result;
  }
}
