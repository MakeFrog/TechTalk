import 'dart:async';

import 'package:techtalk/core/utils/base/base_no_param_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/job/job.dart';

final class GetJobsUseCase extends BaseNoParamUseCase<Result<List<JobEntity>>> {
  GetJobsUseCase(
    this._jobRepository,
  );

  final JobRepository _jobRepository;

  @override
  Future<Result<List<JobEntity>>> call() async {
    return _jobRepository.getJobs();
  }
}
