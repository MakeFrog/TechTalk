import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/tech_set/data/models/job_model.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

final class TechSetLocalDataSourceImpl implements TechSetLocalDataSource {
  @override
  Future<List<JobModel>> getJobs() async {
    final jobsJsonString = await rootBundle.loadString(Assets.jsonJobsData);
    final jobsJson = jsonDecode(jobsJsonString) as List;

    return [
      ...jobsJson.map(
        (e) => JobModel.fromJson(e),
      ),
    ];
  }

  @override
  Future<Map<String, List<Map<String, String>>>> loadSkills() async {
    final jsonString = await rootBundle.loadString(Assets.jsonSkills);
    Map<String, dynamic> jsonData = json.decode(jsonString);

    Map<String, List<Map<String, String>>> convertedData = {};

    jsonData.forEach((key, value) {
      convertedData[key] = List<Map<String, String>>.from(
        value.map((item) => Map<String, String>.from(item)),
      );
    });

    return convertedData;
  }
}
