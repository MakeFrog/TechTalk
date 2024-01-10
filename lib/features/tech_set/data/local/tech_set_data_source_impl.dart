import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/tech_set/data/models/job_model.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

final class JobLocalDataSourceImpl implements JobLocalDataSource {
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
}
