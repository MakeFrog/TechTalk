import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/features/job/data/models/job_group_list_model.dart';
import 'package:techtalk/features/job/data/models/job_group_model.dart';
import 'package:techtalk/features/job/data/remote/job_remote_data_source.dart';

final class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<JobGroupModel> get _jobGroupCollection =>
      _firestore.collection(FirestoreCollection.jobGroups.name).withConverter(
            fromFirestore: (snapshot, _) =>
                JobGroupModel.fromFirestore(snapshot),
            toFirestore: (value, _) => value.toFirestore(),
          );

  @override
  Future<JobGroupListModel> getJobGroups() async {
    final collection = await _jobGroupCollection.orderBy('name').get();

    final groups = collection.docs
        .map(
          (e) => e.data(),
        )
        .toList();

    return JobGroupListModel(
      totalCount: collection.size,
      groups: groups,
    );
  }
}
