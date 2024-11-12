import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/contents/data_source/remote/models/video_contents_overview_model.dart';

abstract class FirestoreVideoContentsOverviewRef {
  static const String _collectionName = 'VideoContentsOverview';

  static CollectionReference<VideoContentsOverviewModel> collection() =>
      FirebaseFirestore.instance.collection(_collectionName).withConverter(
            fromFirestore: VideoContentsOverviewModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<VideoContentsOverviewModel> doc(String id) =>
      FirebaseFirestore.instance.collection(_collectionName).doc(id).withConverter(
            fromFirestore: VideoContentsOverviewModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}
