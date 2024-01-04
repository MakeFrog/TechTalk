import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/job/job.dart';

abstract interface class JobRepository {
  Result<List<JobEntity>> getJobs();
}
