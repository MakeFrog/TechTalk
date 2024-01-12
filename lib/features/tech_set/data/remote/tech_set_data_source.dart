import 'package:techtalk/features/tech_set/tech_set.dart';

abstract interface class TechSetDataSource {
  Future<List<JobEntity>> getJobs();
}
