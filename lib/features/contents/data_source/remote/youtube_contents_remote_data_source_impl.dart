import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_contents_detail_model.dart';
import 'package:techtalk/features/contents/data_source/remote/youtube_contents_detail_ref.dart';
import 'package:techtalk/features/contents/data_source/remote/youtube_contents_remote_data_source.dart';
import 'package:techtalk/features/topic/topic.dart';

final class YoutubeContentsRemoteDataSourceImpl implements YoutubeContentsRemoteDataSource {
  @override
  Future<YoutubeContentsDetailModel> getYoutubeContentsDetail(String contentsId) async {
    final detailDoc = await FirestoreYoutubeDetailRef.doc(contentsId).get();

    if (!detailDoc.exists) {
      throw const FetchYoutubeContentsDetailException();
    }

    return detailDoc.data()!;
  }

  @override
  Future<List<TopicQnaModel>> getYoutubeContentsDetailQnas(String contentsId) async {
    final collection = await FirestoreYoutubeDetailQuestionRef.collection(contentsId).get();

    return collection.docs.map((doc) => doc.data()).toList();
  }
}
