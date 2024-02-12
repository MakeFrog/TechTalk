import 'package:techtalk/features/topic/data_source/remote/models/wrong_answer_model.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract interface class TopicRemoteDataSource {
  Future<List<TopicModel>> getTopics();

  Future<List<TopicQnaModel>> getQnas(String topicId);

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
}
