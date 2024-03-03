import 'package:techtalk/features/topic/topic.dart';

abstract interface class TopicRemoteDataSource {
  ///
  /// 면접 주제 리스트 호출
  ///
  Future<List<TopicModel>> getTopics();

  ///
  /// 문답 리스트 호출
  ///
  Future<List<TopicQnaModel>> getQnas(String topicId);

  ///
  /// 단일 문답 호출
  ///
  Future<TopicQnaModel> getQna(
    String topicId,
    String questionId,
  );

  ///
  /// 오답 데이터 추가 및 업데이트
  ///
  Future<void> updateWrongAnswer(
      {required WrongAnswerModel wrongAnswer, required String topicId});

  ///
  /// 오답 목록 호출
  ///
  Future<List<WrongAnswerModel>> getWrongAnswers(String topicId);

  ///
  /// 유저 오답 목록 제거
  ///
  Future<void> deleteUserWrongAnswers();
}
