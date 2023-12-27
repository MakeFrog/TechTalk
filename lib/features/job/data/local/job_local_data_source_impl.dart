import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/job/data/models/job_model.dart';
import 'package:techtalk/features/job/job.dart';

final class JobLocalDataSourceImpl implements JobLocalDataSource {
  @override
  Future<List<JobModel>> getJobs() async {
    final jobsJsonString = await rootBundle.loadString(Assets.jsonJobsData);
    final jobsJson = jsonDecode(jobsJsonString) as List;

    return [
      ...jobsJson.cast<Map<String, dynamic>>().map(JobModel.fromJson),
    ];
  }
}
