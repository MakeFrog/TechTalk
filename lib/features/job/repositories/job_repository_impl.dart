import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/job/data/models/job_model.dart';
import 'package:techtalk/features/job/job.dart';

final class JobRepositoryImpl implements JobRepository {
  JobRepositoryImpl();

  @override
  Result<List<JobEntity>> getJobs() {
    try {
      return Result.success(
        JobModel.values.map((e) => e.toEntity()).toList(),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
