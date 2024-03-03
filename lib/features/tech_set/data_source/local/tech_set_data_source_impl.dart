import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/tech_set/repositories/enums/job.enum.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

final class TechSetLocalDataSourceImpl implements TechSetLocalDataSource {
  @override
  Future<List<Job>> getJobs() async {
    return Job.values;
  }

  @override
  Future<Map<String, List<Map<String, String>>>> loadSkills() async {
    final jsonString = await rootBundle.loadString(Assets.jsonSkills);
    Map<String, dynamic> jsonData = json.decode(jsonString);

    Map<String, List<Map<String, String>>> convertedData = {};

    jsonData.forEach((key, value) {
      convertedData[key] = List<Map<String, String>>.from(
        value.map(Map<String, String>.from),
      );
    });

    return convertedData;
  }
}
