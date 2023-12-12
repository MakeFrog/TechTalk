import 'dart:async';

import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/job/data/local/job_local_data_source.dart';
import 'package:techtalk/features/job/data/models/job_group_list_model.dart';
import 'package:techtalk/features/job/job.dart';

final class JobRepositoryImpl implements JobRepository {
  const JobRepositoryImpl(
    this._jobLocalDataSource,
  );

  final JobLocalDataSource _jobLocalDataSource;

  @override
  Future<Result<JobGroupListEntity>> getJobGroups() async {
    try {
      final model = _jobLocalDataSource.getJobGroups() as JobGroupListModel;

      return Result.success(
        JobGroupListEntity.fromModel(model),
      );
    } catch (e) {
      return Result.failure(Exception()
          // CustomException(code: 'code', message: '$e'),
          );
    }
  }
}
