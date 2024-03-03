import 'package:techtalk/features/topic/topic.dart';

abstract interface class TopicLocalDataSource {
  ///
  /// 면접 주제 카테고리 데이터 호출
  ///
  Future<List<TopicCategoryModel>> getTopicCategories();

  ///
  /// 문답 목록 호출
  ///
  QnaListBox? loadQnas(String topicId);

  ///
  /// 단일 문답 호출
  ///
  QnaBox? loadSingleQna({required String topicId, required String qnaId});

  ///
  /// 문답 목록 저장
  ///
  Future<void> storeQnas(
      {required String topicId, required List<TopicQnaModel> qnas});
}
