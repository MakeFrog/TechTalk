import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/skill/entities/skill_list_entity.dart';
import 'package:techtalk/features/skill/skill.dart';

class SkillRepositoryImpl implements SkillRepository {
  const SkillRepositoryImpl(
    this._skillRemoteDataSource,
  );

  final SkillRemoteDataSource _skillRemoteDataSource;

  @override
  Future<Result<SkillListEntity>> getSkillsByKeyword(String keyword) async {
    try {
      final skillListModel =
          await _skillRemoteDataSource.getSkillsByKeyword(keyword);

      return Result.success(
        SkillListEntity.fromModel(skillListModel),
      );
    } catch (e) {
      return Result.failure(Exception(e));
    }
  }
}
