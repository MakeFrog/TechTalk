import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/job/data/local/job_local_data_source.dart';
import 'package:techtalk/features/job/data/models/job_ref.dart';
import 'package:techtalk/features/job/job.dart';

final class JobLocalDataSourceImpl implements JobLocalDataSource {
  @override
  Future<List<JobEntity>?> getJobs() async {
    final cachedJobs = await FirestoreJobsRef.collection().get(
      const GetOptions(source: Source.cache),
    );
    if (cachedJobs.docs.isEmpty) {
      return null;
    }

    return [
      ...cachedJobs.docs.map((e) => e.data().toEntity()),
    ];
  }
}
