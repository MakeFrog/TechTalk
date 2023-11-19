import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/study/data/models/study_question_list_model.dart';
import 'package:techtalk/features/study/study.dart';

final class StudyRepositoryFake implements StudyRepository {
  const StudyRepositoryFake({
    required StudyRemoteDataSource studyRemoteDataSource,
    required StudyLocalDataSource studyLocalDataSource,
  })  : _studyRemoteDataSource = studyRemoteDataSource,
        _studyLocalDataSource = studyLocalDataSource;

  final StudyRemoteDataSource _studyRemoteDataSource;
  final StudyLocalDataSource _studyLocalDataSource;

  @override
  Future<Result<StudyQuestionListEntity>> getQuestionList(String techId) async {
    StudyQuestionListModel questionsModel;

    StudyQuestionListModel? cacheQuestionsModel =
        await _studyLocalDataSource.getQuestionList('react');

    if (cacheQuestionsModel != null) {
      final lastUpdateDate =
          await _studyRemoteDataSource.getLastQuestionsUpdateDate('react');
      if (lastUpdateDate.compareTo(cacheQuestionsModel.updateDate) == 0) {
        questionsModel = cacheQuestionsModel;
      } else {
        questionsModel = await _studyRemoteDataSource.getQuestionList('react');
      }
    } else {
      questionsModel = await _studyRemoteDataSource.getQuestionList('react');
    }

    return Result.success(
      StudyQuestionListEntity.fromModel(questionsModel),
    );
  }
}
