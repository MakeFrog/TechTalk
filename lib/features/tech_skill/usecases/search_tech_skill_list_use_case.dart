import 'package:techtalk/features/tech_skill/tech_skill.dart';

final class SearchTechSkillListUseCase {
  const SearchTechSkillListUseCase(
    this._techSkillRepository,
  );

  final TechSkillRepository _techSkillRepository;

  Future<List<TechSkillEntity>> call(String keyword) async {
    return _techSkillRepository.searchTechSkillList(keyword);
  }
}
