import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/job/job.dart';

final class JobRepositoryImpl implements JobRepository {
  const JobRepositoryImpl(
    this._jobRemoteDataSource,
  );

  final JobRemoteDataSource _jobRemoteDataSource;

  @override
  Future<Result<JobGroupListEntity>> getJobGroups() async {
    try {
      final jobGroupsModel = await _jobRemoteDataSource.getJobGroups();

      return Result.success(
        JobGroupListEntity.fromModel(jobGroupsModel),
      );
    } catch (e) {
      return Result.failure(
        CustomException(code: 'code', message: '$e'),
      );
    }
  }
}
