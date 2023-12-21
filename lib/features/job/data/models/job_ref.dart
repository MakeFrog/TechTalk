import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/job/data/models/job_model.dart';

abstract class FirestoreJobsRef {
  static const String name = 'Jobs';

  static CollectionReference<JobModel> collection() =>
      FirebaseFirestore.instance.collection(name).withConverter(
            fromFirestore: JobModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<JobModel> doc(String id) =>
      FirebaseFirestore.instance.collection(name).doc(id).withConverter(
            fromFirestore: JobModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}
