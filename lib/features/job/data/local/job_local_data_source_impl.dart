import 'dart:async';

import 'package:techtalk/features/job/data/local/job_local_data_source.dart';
import 'package:techtalk/features/job/data/models/job_group_list_model.dart';
import 'package:techtalk/features/job/data/models/job_group_model.dart';

final class JobLocalDataSourceImpl implements JobLocalDataSource {
  @override
  FutureOr<JobGroupListModel> getJobGroups() {
    return JobGroupListModel(
      totalCount: JobGroupModel.values.length,
      groups: JobGroupModel.values,
    );
  }
}
