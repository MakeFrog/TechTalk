import 'dart:async';

import 'package:techtalk/features/job/data/models/job_group_list_model.dart';
import 'package:techtalk/features/job/data/remote/job_remote_data_source.dart';

final class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  @override
  Future<JobGroupListModel> getJobGroups() async {
    throw UnimplementedError();
  }
}
