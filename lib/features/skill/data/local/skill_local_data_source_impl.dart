import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/skill/data/local/skill_local_data_source.dart';
import 'package:techtalk/features/skill/data/models/skill_list_model.dart';
import 'package:techtalk/features/skill/data/models/skill_model.dart';

class SkillLocalDataSourceImpl implements SkillLocalDataSource {
  @override
  Future<SkillListModel> getSkillsByKeyword(String keyword) async {
    final jsonString = await rootBundle.loadString(Assets.jsonSkill);
    final List<dynamic> jsonList = jsonDecode(jsonString);

    final skills = jsonList
        .map(
          (e) => SkillModel.fromJson(e),
        )
        .toList();

    return SkillListModel(
      totalCount: skills.length,
      skills: skills,
    );
  }
}
