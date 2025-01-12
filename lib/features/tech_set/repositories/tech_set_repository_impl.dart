import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/tech_set/data_source/remote/tech_set_remote_data_source.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

final class TechSetRepositoryImpl implements TechSetRepository {
  TechSetRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
  );

  final TechSetRemoteDataSource _remoteDataSource;
  final TechSetLocalDataSource _localDataSource;

  final List<SkillEntity> _cachedSkillCollection = [];

  @override
  List<JobGroup> getJobs() => JobGroup.values;

  @override
  Future<void> initSkills() async {
    try {
      // 원격 데이터 가져오기
      final response = await _remoteDataSource.getNewSkills();
      final result = response.map((e) => SkillEntity.fromModel(e));

      _cachedSkillCollection.addAll(result);
    } catch (e) {
      log('Remote data fetch failed, loading from local JSON: $e');

      try {
        // 로컬 JSON 파일에서 데이터 가져오기
        String jsonString =
            await rootBundle.loadString('assets/json/skills.json');
        Map<String, dynamic> jsonData = jsonDecode(jsonString);

        // JSON 데이터를 SkillEntity로 변환
        final List<SkillEntity> fallbackSkills = [];
        jsonData.forEach((category, skillList) {
          for (var skill in skillList) {
            fallbackSkills
                .add(SkillEntity.fromJson(json: skill, category: category));
          }
        });

        // 캐시에 추가
        _cachedSkillCollection.addAll(fallbackSkills);
        log('Loaded skills from local JSON successfully.');
      } catch (localError) {
        log('Error loading skills from local JSON: $localError');
        rethrow;
      }
    }
  }

  @override
  SkillEntity getSkillById(String id) {
    final targetSkill =
        _cachedSkillCollection.firstWhereOrNull((e) => e.id == id);
    return targetSkill ?? SkillEntity.undefined();
  }

  @override
  List<SkillEntity> getSkills() => _cachedSkillCollection;
}
