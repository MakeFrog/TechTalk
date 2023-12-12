import 'dart:async';

import 'package:techtalk/features/job/data/models/job_group_list_model.dart';

abstract interface class JobLocalDataSource {
  FutureOr<JobGroupListModel> getJobGroups();
}
