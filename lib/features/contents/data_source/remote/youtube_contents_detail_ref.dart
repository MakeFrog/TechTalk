// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:techtalk/features/contents/data_source/remote/models/summary_model.dart';
// import 'package:techtalk/features/contents/data_source/remote/models/youtube_contents_detail_model.dart';
// import 'package:techtalk/features/topic/topic.dart';
//
//
//
// @override
// Future<void> addYoutubeContentsDetail(
//     String contentsId, YoutubeContentsDetailModel detailModel) async {
//   final ref =
//       FirebaseFirestore.instance.collection('YoutubeDetail').doc(contentsId);
//
//   await ref.set(detailModel.toJson());
// }
//
// @override
// Future<void> addYoutubeContentsQnas(
//     String contentsId, List<TopicQnaModel> qnas) async {
//   for (var qna in qnas) {
//     await FirebaseFirestore.instance
//         .collection('YoutubeDetail')
//         .doc(contentsId)
//         .collection('Qna')
//         .add(qna.toJson());
//   }
// }
