import 'dart:async';
import 'dart:developer';
import 'package:techtalk/app/util/app_format_handler.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/tech_set/data_source/remote/model/tech_set_keys_model.dart';
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
  List<Job> getJobs() => Job.values;

  @override
  Future<void> initSkills() async {
    try {
      final cachedSkillSet = _localDataSource.loadCachedSkillSet();
      final remoteKey =
          (await _remoteDataSource.getKeys()).skill ?? 'undefined';
      final localKey = cachedSkillSet?.keys.first;

      /// 원격 호출
      if (cachedSkillSet == null || remoteKey != localKey) {
        final remoteRes = await _remoteDataSource.getSkills();
        final convertedData = AppFormatHandler.parseMapSLMaSSJson(remoteRes);

        for (var entry in convertedData.entries) {
          _cachedSkillCollection.addAll(entry.value
              .map((e) => SkillEntity.fromJson(json: e, category: entry.key)));
        }

        /// 로컬스터리지에 스킬 데이터 저장
        unawaited(
          _localDataSource.storeSkillSet(
            skillSet: {remoteKey: convertedData},
          ),
        );
      }

      /// 캐싱된 데이터 호출
      else {
        for (var entry in cachedSkillSet.values.first.entries) {
          _cachedSkillCollection.addAll(entry.value
              .map((e) => SkillEntity.fromJson(json: e, category: entry.key)));
        }
      }
    } catch (e) {
      log('Error initializing skills: $e');
      rethrow;
    }
  }

  @override
  SkillEntity getSkillById(String id) {
    return _cachedSkillCollection.firstWhere((e) => e.id == id);
  }

  @override
  List<SkillEntity> getSkills() => _cachedSkillCollection;

  @override
  Future<Result<TechSetKeysModel>> getKeys() async {
    try {
      final response = await _remoteDataSource.getKeys();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
