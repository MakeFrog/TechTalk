import 'package:techtalk/features/tech_skill/entities/tech_skill_entity.dart';
import 'package:techtalk/features/tech_skill/tech_skill.dart';

class TechSkillRepositoryImpl implements TechSkillRepository {
  const TechSkillRepositoryImpl(
    this._techSkillRemoteDataSource,
  );

  final TechSkillRemoteDataSource _techSkillRemoteDataSource;

  @override
  Future<List<TechSkillEntity>> searchTechSkillList(String keyword) async {
    final model = await _techSkillRemoteDataSource.searchTechSkillList(keyword);
    final entities = model.map(TechSkillEntity.fromModel).toList();

    return entities;
  }
}
