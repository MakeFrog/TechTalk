import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/contents/data_source/remote/models/summary_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_content_detail_new_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_video_contents_overview_model.dart';

abstract class FirestoreYoutubeContentsOverviewRef {
  static const String collectionName = 'YoutubeOverview';

  static CollectionReference<YoutubeContentsOverviewModel> collection() =>
      FirebaseFirestore.instance.collection(collectionName).withConverter(
            fromFirestore: YoutubeContentsOverviewModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<YoutubeContentsOverviewModel> doc(String id) =>
      FirebaseFirestore.instance
          .collection(collectionName)
          .doc(id)
          .withConverter(
            fromFirestore: YoutubeContentsOverviewModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference channelDocumentRef(String channelId) =>
      FirebaseFirestore.instance.collection('Channel').doc(channelId);
}

///
/// 특정 유튜브 상세(서머리) ref
///
abstract class FirestoreYoutubeDetailNewRef {
  static const String name = 'Detail';

  static DocumentReference<YoutubeContentsDetailNewModel> collection(
          String contentsId) =>
      FirebaseFirestore.instance
          .collection(FirestoreYoutubeContentsOverviewRef.collectionName)
          .doc(contentsId)
          .collection(name)
          .doc(contentsId)
          .withConverter(
            fromFirestore: YoutubeContentsDetailNewModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}

@override
Future<void> addYoutubeContentsOverview(
    String contentsId, YoutubeContentsOverviewModel overviewModel) async {
  final ref =
      FirebaseFirestore.instance.collection('YoutubeOverview').doc(contentsId);

  await ref.set(overviewModel.toJson());
}
