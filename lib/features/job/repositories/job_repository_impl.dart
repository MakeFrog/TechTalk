import 'dart:async';

import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/job/job.dart';

final class JobRepositoryImpl implements JobRepository {
  JobRepositoryImpl(
    this._jobRemoteDataSource,
    this._jobLocalDataSource,
  );

  final JobRemoteDataSource _jobRemoteDataSource;
  final JobLocalDataSource _jobLocalDataSource;

  List<JobEntity>? _cachedJobs;

  @override
  Future<void> initStaticData() async {
    final jobsModel = await _jobLocalDataSource.getJobs();
    _cachedJobs ??= jobsModel.map((e) => e.toEntity()).toList();
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
