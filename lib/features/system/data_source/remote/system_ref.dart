import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/system/system.dart';

abstract class FirestoreVersionRef {
  static const String name = 'Version';

  static CollectionReference<VersionModel> collection() =>
      FirebaseFirestore.instance.collection(name).withConverter(
            fromFirestore: VersionModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<VersionModel> doc(String id) =>
      FirebaseFirestore.instance.collection(name).doc(id).withConverter(
            fromFirestore: VersionModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}
