import 'package:techtalk/features/job/job.dart';

abstract interface class JobRemoteDataSource {
  Future<List<JobEntity>> getJobs();
}
