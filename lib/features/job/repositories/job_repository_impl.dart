import 'package:techtalk/features/job/data/remote/job_remote_data_source.dart';
import 'package:techtalk/features/job/models/job_group_model.dart';
import 'package:techtalk/features/job/repositories/job_repository.dart';

final class JobRepositoryImpl implements JobRepository {
  const JobRepositoryImpl(
    this._jobRemoteDataSource,
  );

  final JobRemoteDataSource _jobRemoteDataSource;

  @override
  Future<JobGroupListModel> getJobGroupList() {
    return _jobRemoteDataSource.getJobGroupList();
  }
}
