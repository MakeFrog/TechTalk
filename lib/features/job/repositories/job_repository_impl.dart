import 'dart:async';

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
  Future<Result<List<JobEntity>>> getJobs() async {
    try {
      final cachedJobs = await _jobLocalDataSource.getJobs();
      if (cachedJobs != null) {
        return Result.success(cachedJobs);
      }

      final jobs = await _jobRemoteDataSource.getJobs();

      return Result.success(jobs);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
