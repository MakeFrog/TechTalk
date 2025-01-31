import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/tech_set/data_source/local/boxes/tech_set_box.dart';
import 'package:techtalk/features/tech_set/repositories/entities/job_group_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

final class TechSetLocalDataSourceImpl implements TechSetLocalDataSource {
  TechSetLocalDataSourceImpl(this._box);

  final Box<TechSetBox> _box;

  @override
  Future<List<JobGroupEntity>> getJobs() async {
    return JobGroupTypes.values.map((e) => JobGroupEntity.fromEnum(e)).toList();
  }

  @override
  Map<String, Map<String, List<Map<String, String>>>>? loadCachedSkillSet() {
    return _box.get(AppLocal.techSetBoxName)?.skillJson;
  }

  @override
  Future<void> storeSkillSet({
    required Map<String, Map<String, List<Map<String, String>>>> skillSet,
  }) async {
    final target = _box.values.firstOrNull ?? TechSetBox(skillJson: null);
    await _box.put(
      AppLocal.techSetBoxName,
      target.copyWith(skillJson: skillSet),
    );
  }
}
