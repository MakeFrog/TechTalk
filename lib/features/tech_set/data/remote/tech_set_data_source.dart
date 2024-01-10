import 'package:techtalk/features/tech_set/tech_set.dart';

abstract interface class JobRemoteDataSource {
  Future<List<JobEntity>> getJobs();
}
