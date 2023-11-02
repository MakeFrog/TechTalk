import 'package:techtalk/core/models/custom_exception.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/job/entities/job_group_list_entity.dart';
import 'package:techtalk/features/job/job.dart';

final class JobRepositoryImpl implements JobRepository {
  const JobRepositoryImpl(
    this._jobRemoteDataSource,
  );

  final JobRemoteDataSource _jobRemoteDataSource;

  @override
  Future<Result<JobGroupListEntity>> getJobGroupList() async {
    try {
      final jobGroupsModel = await _jobRemoteDataSource.getJobGroupList();

      return Result.success(
        JobGroupListEntity(
          groups: jobGroupsModel.groups.map(JobGroupEntity.fromModel).toList(),
        ),
      );
    } catch (e) {
      return Result.failure(
        CustomException(code: 'code', message: '$e'),
      );
    }
  }
}
