import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_contents_detail_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_video_contents_overview_model.dart';

abstract class FirestoreYoutubeDetailRef {
  static const String _collectionName = 'YoutubeDetail';

  static CollectionReference<YoutubeContentsOverviewModel> collection() =>
      FirebaseFirestore.instance.collection(_collectionName).withConverter(
            fromFirestore: YoutubeContentsOverviewModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<YoutubeContentsOverviewModel> doc(String id) =>
      FirebaseFirestore.instance.collection(_collectionName).doc(id).withConverter(
            fromFirestore: YoutubeContentsOverviewModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}

@override
Future<void> addYoutubeContentsDetail(String contentsId, YoutubeContentsDetailModel detailModel) async {
  final ref = FirebaseFirestore.instance.collection('YoutubeDetail').doc(contentsId);

  await ref.set(detailModel.toJson());
}
