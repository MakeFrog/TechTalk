import 'package:techtalk/features/job/data/models/job_model.dart';

abstract interface class JobLocalDataSource {
  Future<List<JobModel>> getJobs();
}
