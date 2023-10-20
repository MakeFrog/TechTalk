import 'package:techtalk/features/job/models/job_group_model.dart';

abstract interface class JobRemoteDataSource {
  Future<JobGroupListModel> getJobGroupList();
}
