import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/tech_set/data_source/remote/model/job_group_model.dart';

abstract class FirestoreJobGroupRef {
  static const String _name = 'JobGroup';

  static CollectionReference<JobGroupModel> collection() =>
      FirebaseFirestore.instance.collection(_name).withConverter(
            fromFirestore: JobGroupModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<JobGroupModel> document(String jobGroupId) =>
      FirebaseFirestore.instance
          .collection(_name)
          .doc(jobGroupId)
          .withConverter(
            fromFirestore: JobGroupModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}
