import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/contents/data_source/remote/models/contents_author_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/summary_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_content_detail_new_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_qna_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_video_contents_overview_model.dart';
import 'package:techtalk/features/topic/data_source/remote/models/topic_qna_model.dart';

abstract class FirestoreYoutubeContentsOverviewRef {
  static const String collectionName = 'YoutubeOverview';

  static CollectionReference<YoutubeContentsOverviewModel> collection() =>
      FirebaseFirestore.instance.collection(collectionName).withConverter(
            fromFirestore: YoutubeContentsOverviewModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<YoutubeContentsOverviewModel> doc(
          String contentId) =>
      FirebaseFirestore.instance
          .collection(collectionName)
          .doc(contentId)
          .withConverter(
            fromFirestore: YoutubeContentsOverviewModel.fromFirestore,
            toFirestore: YoutubeContentsOverviewModel.toFiresTore,
          );

  static DocumentReference channelDocumentRef(String channelId) =>
      FirebaseFirestore.instance.collection('Channel').doc(channelId);
}

///
/// 유튜브 콘텐츠 상세(서머리) ref
///
abstract class FirestoreYoutubeDetailNewRef {
  static const String name = 'Detail';

  static DocumentReference<YoutubeContentsDetailNewModel> doc(
          String contentId) =>
      FirebaseFirestore.instance
          .collection(FirestoreYoutubeContentsOverviewRef.collectionName)
          .doc(contentId)
          .collection(name)
          .doc(contentId)
          .withConverter(
            fromFirestore: YoutubeContentsDetailNewModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}

///
/// 유트브 콘텐츠 문답
///
abstract class FirestoreYoutubeQnaNewRef {
  static const String name = 'Qna';

  static CollectionReference<YoutubeQnaModel> collection(String contentsId) =>
      FirebaseFirestore.instance
          .collection(FirestoreYoutubeContentsOverviewRef.collectionName)
          .doc(contentsId)
          .collection(name)
          .withConverter(
            fromFirestore: YoutubeQnaModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  Future<void> addYoutubeContentsOverview(
      String contentsId, YoutubeContentsOverviewModel overviewModel) async {
    final ref = FirebaseFirestore.instance
        .collection('YoutubeOverview')
        .doc(contentsId);

    await ref.set(overviewModel.toJson());
  }
}

///
/// 채널 정보
///
abstract class FirestoreYoutubeChannelRef {
  static const String name = 'Channel';

  static DocumentReference<ChannelModel> document(String channelId) =>
      FirebaseFirestore.instance.collection(name).doc(channelId).withConverter(
            fromFirestore: ChannelModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  @override
  Future<void> addYoutubeContentsOverview(
      String contentsId, YoutubeContentsOverviewModel overviewModel) async {
    final ref = FirebaseFirestore.instance
        .collection('YoutubeOverview')
        .doc(contentsId);

    await ref.set(overviewModel.toJson());
  }
}
