import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/features/job/data/remote/job_remote_data_source.dart';
import 'package:techtalk/features/job/models/job_group_model.dart';

final class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<JobGroupListModel> getJobGroupList() async {
    final snapShot =
        await _firestore.collection(FirestoreCollection.jobGroups.name).get();

    final groups = snapShot.docs.map(JobGroupModel.fromFirestore).toList();

    return JobGroupListModel(
      groups: groups,
    );
  }
}
