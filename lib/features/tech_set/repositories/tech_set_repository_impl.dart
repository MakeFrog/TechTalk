import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:techtalk/features/tech_set/data_source/remote/tech_set_remote_data_source.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

final class TechSetRepositoryImpl implements TechSetRepository {
  TechSetRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
  );

  final TechSetRemoteDataSource _remoteDataSource;
  final TechSetLocalDataSource _localDataSource;

  final List<SkillEntity> _cachedSkillCollection = [];

  final List<JobGroupEntity> _cachedJobGroups = [];

  @override
  List<JobGroupEntity> getJobs() => _cachedJobGroups;

  @override
  Future<void> initSkills() async {
    try {
      // 원격 데이터 가져오기
      final response = await _remoteDataSource.getSkills();
      final result = response.map((e) => SkillEntity.fromModel(e));

      _cachedSkillCollection.addAll(result);
    } catch (e) {
      log('Remote data fetch failed, loading from local JSON: $e');

      /// 원격 호출 실패 시
      /// 로컬 JSON 파일에서 데이터 가져오기
      try {
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
  Future<void> initJobGroups() async {
    try {
      // 원격 데이터 가져오기
      final response = await _remoteDataSource.getJobGroups();
      final result = response.map((e) => JobGroupEntity.fromModel(e));

      _cachedJobGroups.addAll(result);
      log('Loaded job groups from remote data source successfully.');
    } catch (e) {
      log('Remote data fetch failed, loading from enum: $e');

      // 원격 호출 실패 시, JobGroup enum에서 매핑
      try {
        final fallbackJobGroups = await _localDataSource.getJobs();

        _cachedJobGroups.addAll(fallbackJobGroups);
        log('Loaded job groups from enum successfully.');
      } catch (enumError) {
        log('Error loading job groups from enum: $enumError');
        rethrow;
      }
    }
  }

  @override
  SkillEntity getSkillById(String id) {
    final targetSkill = _cachedSkillCollection.firstWhereOrNull((e) {
      return e.id.toLowerCase() == id.toLowerCase();
    });
    if (targetSkill == null) {
      log('Undefined skill found with id: $id');
      return SkillEntity.undefined();
    }
    return targetSkill;
  }

  @override
  List<SkillEntity> getSkills() => _cachedSkillCollection;

  @override
  JobGroupEntity getJobGroupById(String id) {
    final targetJobGroup = _cachedJobGroups
        .firstWhereOrNull((e) => e.id.toLowerCase() == id.toLowerCase());
    return targetJobGroup ?? JobGroupEntity.undefined();
  }
}
