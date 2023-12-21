import 'dart:async';

import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/job/job.dart';

abstract interface class JobRepository {
  Future<void> initStaticData();
  Result<List<JobEntity>> getJobs();
}
