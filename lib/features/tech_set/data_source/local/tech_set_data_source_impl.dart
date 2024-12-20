import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:techtalk/app/util/app_format_handler.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/tech_set/data_source/local/boxes/tech_set_box.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

final class TechSetLocalDataSourceImpl implements TechSetLocalDataSource {
  TechSetLocalDataSourceImpl(this._box);

  final Box<TechSetBox> _box;

  @override
  Future<List<Job>> getJobs() async => Job.values;

  @override
  Future<Map<String, List<Map<String, String>>>> loadSkills() async {
    final jsonString = await rootBundle.loadString(Assets.jsonSkills);
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    return AppFormatHandler.parseMapSLMaSSJson(jsonData);
  }

  @override
  Future<Map<String, List<Map<String, String>>>> loadNewSkills() async {
    final jsonString = await rootBundle.loadString(Assets.jsonNewJson);
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    return AppFormatHandler.parseMapSLMaSSJson(jsonData);
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
