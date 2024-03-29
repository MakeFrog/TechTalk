import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract interface class TopicRepository {
  ///
  /// 문답 리스트 호출
  ///
  Future<Result<List<QnaEntity>>> getTopicQnas(
    String topicId,
  );

  ///
  /// 단일 문답 호출
  ///
  Future<Result<QnaEntity>> getTopicQna(
    String topicId,
    String questionId,
  );

  ///
  /// 오답 노트 기록 업데이트
  ///
  Future<Result<void>> updateWrongAnswer(ChatQnaEntity chatQna);

  ///
  /// 오답 노트 목록 호출
  ///
  Future<Result<List<WrongAnswerEntity>>> getWrongAnswers(String topicId);

  ///
  /// 오답 노트 목록 제거
  ///
  Future<Result<void>> deleteUserWrongAnswers();
}
