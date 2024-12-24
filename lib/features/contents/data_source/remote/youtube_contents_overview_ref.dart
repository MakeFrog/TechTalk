import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_video_contents_overview_model.dart';

abstract class FirestoreYoutubeContentsOverviewRef {
  static const String _collectionName = 'YoutubeOverview';

  static CollectionReference<YoutubeContentsOverviewModel> collection() =>
      FirebaseFirestore.instance.collection(_collectionName).withConverter(
            fromFirestore: YoutubeContentsOverviewModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<YoutubeContentsOverviewModel> doc(String id) =>
      FirebaseFirestore.instance
          .collection(_collectionName)
          .doc(id)
          .withConverter(
            fromFirestore: YoutubeContentsOverviewModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference channelDocumentRef(String channelId) =>
      FirebaseFirestore.instance.collection('Channel').doc(channelId);
}

@override
Future<void> addYoutubeContentsOverview(
    String contentsId, YoutubeContentsOverviewModel overviewModel) async {
  final ref =
      FirebaseFirestore.instance.collection('YoutubeOverview').doc(contentsId);

  await ref.set(overviewModel.toJson());
}
