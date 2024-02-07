import 'package:techtalk/features/tech_set/data_source/remote/models/job_model.dart';

abstract interface class TechSetDataSource {
  Future<List<Job>> getJobs();
}
