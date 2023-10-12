import 'package:techtalk/features/job/job.dart';

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
