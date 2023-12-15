import 'dart:async';

import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/job/entities/job_group_list_entity.dart';

abstract interface class JobRepository {
  Future<Result<JobGroupListEntity>> getJobGroups();
}
