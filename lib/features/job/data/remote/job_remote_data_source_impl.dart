import 'dart:async';

import 'package:techtalk/features/job/data/models/job_ref.dart';
import 'package:techtalk/features/job/job.dart';

final class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  @override
  Future<List<JobEntity>> getJobs() async {
    final cachedJobs = await FirestoreJobsRef.collection().get();

    return [
      ...cachedJobs.docs.map((e) => e.data().toEntity()),
    ];
  }
}
