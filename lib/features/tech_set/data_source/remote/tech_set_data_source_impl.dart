// import 'dart:async';
//
//
// import 'package:techtalk/features/tech_set/tech_set.dart';
//
// final class TechSetRemoteDataSourceImpl implements TechSetDataSource {
//   @override
//   Future<List<JobEntity>> getJobs() async {
//     final cachedJobs = await FirestoreJobsRef.collection().get();
//
//     return [
//       ...cachedJobs.docs.map((e) => e.data().toEntity()),
//     ];
//   }
// }