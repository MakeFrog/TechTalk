import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_contents_detail_model.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract class FirestoreYoutubeDetailRef {
  static const String _collectionName = 'YoutubeDetail';

  static CollectionReference<YoutubeContentsDetailModel> collection() =>
      FirebaseFirestore.instance.collection(_collectionName).withConverter(
            fromFirestore: YoutubeContentsDetailModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<YoutubeContentsDetailModel> doc(String contentsId) =>
      FirebaseFirestore.instance.collection(_collectionName).doc(contentsId).withConverter(
            fromFirestore: YoutubeContentsDetailModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}

///
/// 특정 유튜브 영상의 관련 질문들
///
abstract class FirestoreYoutubeDetailQuestionRef {
  static const String name = 'Qna';

  static CollectionReference<TopicQnaModel> collection(String contentsId) =>
      FirestoreYoutubeDetailRef.doc(contentsId).collection(name).withConverter(
            fromFirestore: TopicQnaModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}

@override
Future<void> addYoutubeContentsDetail(String contentsId, YoutubeContentsDetailModel detailModel) async {
  final ref = FirebaseFirestore.instance.collection('YoutubeDetail').doc(contentsId);

  await ref.set(detailModel.toJson());
}

@override
Future<void> addYoutubeContentsQnas(String contentsId, List<TopicQnaModel> qnas) async {
  for (var qna in qnas) {
    await FirebaseFirestore.instance.collection('YoutubeDetail').doc(contentsId).collection('Qna').add(qna.toJson());
  }
}
