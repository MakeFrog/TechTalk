import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/interview.dart';

class InterviewRepositoryImpl implements InterviewRepository {
  const InterviewRepositoryImpl({
    required InterviewLocalDataSource interviewLocalDataSource,
    required InterviewRemoteDataSource interviewRemoteDataSource,
  })  : _interviewLocalDataSource = interviewLocalDataSource,
        _interviewRemoteDataSource = interviewRemoteDataSource;
  final InterviewLocalDataSource _interviewLocalDataSource;
  final InterviewRemoteDataSource _interviewRemoteDataSource;

  @override
  List<InterviewTopic> getTopics() {
    return _interviewLocalDataSource.getTopics();
  }

  @override
  Future<Result<List<InterviewQnAEntity>>> getReviewNoteQuestions({
    required String userUid,
    required String topicId,
  }) async {
    try {
      final questionsModel =
          await _interviewRemoteDataSource.getReviewNoteQuestions(
        userUid: userUid,
        topicId: topicId,
      );

      final questionsEntity = questionsModel.map((e) {
        return InterviewQnAEntity(
          id: e.id,
          question: e.question,
          idealAnswer: e.answers,
          response: UserInterviewResponse(
            e.myAnswer,
            state: AnswerState.wrong,
          ),
        );
      }).toList();

      return Result.success(questionsEntity);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
