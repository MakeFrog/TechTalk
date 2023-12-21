import 'dart:async';

import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/job/job.dart';

final class JobRepositoryImpl implements JobRepository {
  JobRepositoryImpl(
    this._jobRemoteDataSource,
  );

  final JobRemoteDataSource _jobRemoteDataSource;

  List<JobEntity>? _cachedJobs;

  @override
  Future<void> initStaticData() async {
    _cachedJobs ??= await _jobRemoteDataSource.getJobs();
  }

  @override
  Result<List<JobEntity>> getJobs() {
    try {
      return Result.success(_cachedJobs!);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
