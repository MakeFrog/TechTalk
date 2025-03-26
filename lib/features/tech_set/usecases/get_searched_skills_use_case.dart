import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

final class GetSearchedSkillsUseCase
    extends BaseNoFutureUseCase<String, Result<List<SkillEntity>>> {
  @override
  Result<List<SkillEntity>> call(String param) {
    try {
      // 캐시된 스킬 데이터 가져오기
      final getCachedSkills = techSetRepository.getSkills();

      final filteredSkills = getCachedSkills.where((e) {
        final normalizedName = e.name.normalizeSearchString;
        final normalizedTerm = param.normalizeSearchString;

        return normalizedName.contains(normalizedTerm);
      }).toList();

      return Result.success(filteredSkills);
    } on Exception catch (e) {
      // 예외 처리
      return Result.failure(e);
    }
  }
}
