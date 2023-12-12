import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview_new/entities/interview_qna_entity.dart';
import 'package:techtalk/features/interview_new/repositories/interview_repository.dart';

final class GetWrongAnswersOfTopicUseCase {
  const GetWrongAnswersOfTopicUseCase(this._interviewRepository);

  final InterviewRepository _interviewRepository;

  Future<Result<List<InterviewQnAEntity>>> call({
    required String userUid,
    required String topicId,
  }) async {
    return _interviewRepository.getQnAsOfTopic(
      userUid: userUid,
      topicId: topicId,
    );
  }
}
