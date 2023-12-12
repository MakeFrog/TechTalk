import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/skill/data/local/skill_local_data_source.dart';
import 'package:techtalk/features/skill/entities/skill_list_entity.dart';
import 'package:techtalk/features/skill/skill.dart';

class SkillRepositoryImpl implements SkillRepository {
  const SkillRepositoryImpl(
    this._skillRemoteDataSource,
    this._skillLocalDataSource,
  );

  final SkillRemoteDataSource _skillRemoteDataSource;
  final SkillLocalDataSource _skillLocalDataSource;

  @override
  Future<Result<SkillListEntity>> getSkillsByKeyword(String keyword) async {
    try {
      final skillListModel =
          await _skillLocalDataSource.getSkillsByKeyword(keyword);

      return Result.success(
        SkillListEntity.fromModel(skillListModel),
      );
    } catch (e) {
      return Result.failure(Exception(e));
    }
  }
}
