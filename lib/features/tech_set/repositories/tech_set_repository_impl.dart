import 'dart:async';

import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/tech_set/entities/skill_collection_entity.dart';
import 'package:techtalk/features/tech_set/entities/skill_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

final class TechSetRepositoryImpl implements TechSetRepository {
  TechSetRepositoryImpl(
    this._techSetRemoteDataSource,
    this._techSetLocalDataSource,
  );

  final TechSetDataSource _techSetRemoteDataSource;
  final TechSetLocalDataSource _techSetLocalDataSource;

  final List<SkillCollectionEntity> _cachedSkillCollection = [];
  List<JobEntity>? _cachedJobs;

  @override
  Future<void> initStaticData() async {
    final jobsModel = await _techSetLocalDataSource.getJobs();
    _cachedJobs ??= jobsModel.map((e) => e.toEntity()).toList();
  }

  @override
  Result<List<JobEntity>> getJobs() {
    try {
      return Result.success(_cachedJobs!);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<void> initSkills() async {
    try {
      final jsonData = await _techSetLocalDataSource.loadSkills();

      _cachedSkillCollection.addAll(
        jsonData.entries.map(
          (entry) {
            List<SkillEntity> skills =
                entry.value.map(SkillEntity.fromJson).toList();

            return SkillCollectionEntity(firstLetter: entry.key, items: skills);
          },
        ),
      );
    } catch (e) {
      throw const MappingFailedException();
    }
  }

  @override
  Result<SkillCollectionEntity> getSkillsByFirstLetter(String letter) {
    try {
      final response =
          _cachedSkillCollection.firstWhere((e) => e.firstLetter == letter);

      return Result.success(response);
    } on Exception catch (e) {
      if (e is MappingFailedException) {
        return Result.failure(e);
      }

      return Result.failure(const FetchSkillsFailedException());
    }
  }

  @override
  SkillEntity getSkillById(String id) {
    final firstLetter = id[0];

    final collection =
        _cachedSkillCollection.firstWhere((e) => e.firstLetter == firstLetter);
    final specificSkill = collection.items.firstWhere((e) => e.id == id);

    return specificSkill;
  }
}
