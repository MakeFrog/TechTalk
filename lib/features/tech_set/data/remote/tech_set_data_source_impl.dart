import 'dart:async';

import 'package:techtalk/features/tech_set/data/models/job_ref.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

final class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  @override
  Future<List<JobEntity>> getJobs() async {
    final cachedJobs = await FirestoreJobsRef.collection().get();

    return [
      ...cachedJobs.docs.map((e) => e.data().toEntity()),
    ];
  }
}
