import 'package:techtalk/features/job/job.dart';

abstract interface class JobLocalDataSource {
  Future<List<JobEntity>?> getJobs();
}
