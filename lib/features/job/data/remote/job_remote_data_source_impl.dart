import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/features/job/job.dart';
import 'package:techtalk/features/job/models/job_group_model.dart';

final class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<JobGroupListModel> getJobGroupList() async {
    final snapShot =
        await _firestore.collection(FirestoreCollection.jobGroups.name).get();

    log(snapShot.docs.first.data().toString());

    final groups = snapShot.docs
        .map(
          (e) => JobGroupModel.fromFirestore(
            e.id,
            e.data(),
          ),
        )
        .toList();

    return JobGroupListModel(
      groups: groups,
    );
  }
}
