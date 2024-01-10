import 'package:techtalk/features/tech_set/data/models/job_model.dart';

abstract interface class JobLocalDataSource {
  Future<List<JobModel>> getJobs();
}
