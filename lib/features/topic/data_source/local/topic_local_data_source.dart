import 'package:techtalk/features/topic/data_source/local/boxes/qna_box.dart';
import 'package:techtalk/features/topic/data_source/local/boxes/qna_list_box.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract interface class TopicLocalDataSource {
  Future<List<TopicCategoryModel>> getTopicCategories();
  Future<List<TopicQnaModel>?> getQnas(String topicId);

  Future<TopicQnaModel?> getQna(
    String topicId,
    String questionId,
  );

  /// Qna 목록 호출
  QnaListBox? loadQnas(String topicId);

  /// 단일 Qna 호출
  QnaBox? loadSingleQna({required String topicId, required String qnaId});

  /// Qna 목록 저장
  Future<void> storeQnas(
      {required String topicId, required List<TopicQnaModel> qnas});
}
