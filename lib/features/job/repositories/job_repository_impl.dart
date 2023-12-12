import 'dart:async';

import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/job/data/local/job_local_data_source.dart';
import 'package:techtalk/features/job/job.dart';

final class JobRepositoryImpl implements JobRepository {
  const JobRepositoryImpl(
    this._jobRemoteDataSource,
    this._jobLocalDataSource,
  );

  final JobRemoteDataSource _jobRemoteDataSource;
  final JobLocalDataSource _jobLocalDataSource;

  @override
  Future<Result<JobGroupListEntity>> getJobGroups() async {
    final model = await _jobLocalDataSource.getJobGroups();

    return Result.success(
      JobGroupListEntity.fromModel(model),
    );

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
