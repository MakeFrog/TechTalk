import 'package:techtalk/features/job/data/models/job_group_list_model.dart';

abstract interface class JobRemoteDataSource {
  Future<JobGroupListModel> getJobGroups();
}
