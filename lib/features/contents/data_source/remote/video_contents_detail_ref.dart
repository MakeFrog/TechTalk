import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/contents/data_source/remote/models/contents_detail_model.dart';

abstract class FirestoreVideoContentsDetailRef {
  static const String _collectionName = 'VideoContentsDetail';

  static CollectionReference<ContentsDetailModel> collection() =>
      FirebaseFirestore.instance.collection(_collectionName).withConverter(
            fromFirestore: ContentsDetailModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<ContentsDetailModel> doc(String id) =>
      FirebaseFirestore.instance.collection(_collectionName).doc(id).withConverter(
            fromFirestore: ContentsDetailModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}
