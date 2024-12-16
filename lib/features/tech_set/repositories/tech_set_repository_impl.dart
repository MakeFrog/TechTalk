import 'dart:async';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skill_set_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

final class TechSetRepositoryImpl implements TechSetRepository {
  TechSetRepositoryImpl(
    this._techSetLocalDataSource,
  );

  final TechSetLocalDataSource _techSetLocalDataSource;

  final List<SkillSetEntity> _cachedSkillCollection = [];

  @override
  List<Job> getJobs() {
    return Job.values;
  }

  @override
  Future<void> initSkills() async {
    try {
      // final jsonData = await _techSetLocalDataSource.loadSkills();
      final jsonData = await _techSetLocalDataSource.loadNewSkills();
      print('아랑이 2  :${jsonData}');

      for (var entry in jsonData.entries) {
        final List<SkillSetEntity> skills = entry.value
            .map((e) => SkillSetEntity.fromJson(json: e, category: entry.key))
            .toList();
        _cachedSkillCollection.addAll(skills);
      }
    } catch (e) {
      print('아랑이 : ${e}');
      throw const MappingFailedException();
    }
  }

  @override
  Result<SkillCollectionEntity> getSkillsByFirstLetter(String letter) {
    try {
      // final response =
      //     _cachedSkillCollection.firstWhere((e) => e.firstLetter == letter);

      return Result.success(
          SkillCollectionEntity(firstLetter: 'firstLetter', items: []));
    } on Exception catch (e) {
      if (e is MappingFailedException) {
        return Result.failure(e);
      }

      return Result.failure(const FetchSkillsFailedException());
    }
  }

  @override
  SkillSetEntity getSkillById(String id) {
    return _cachedSkillCollection.firstWhere((e) => e.id == id);
  }

  @override
  List<SkillSetEntity> getSkills() {
    return _cachedSkillCollection;
  }
}
