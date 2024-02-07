import 'package:techtalk/features/topic/data_source/local/boxes/qna_list_box.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract interface class TopicLocalDataSource {
  Future<List<TopicCategoryModel>> getTopicCategories();
  Future<List<TopicQnaModel>?> getQnas(String topicId);

  Future<TopicQnaModel?> getQna(
    String topicId,
    String questionId,
  );

  QnaListBox? loadQnas(String topicId);

  Future<void> storeQnas(
      {required String topicId, required List<TopicQnaModel> qnas});
}
