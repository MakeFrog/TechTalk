import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/study/data/models/study_question_list_model.dart';
import 'package:techtalk/features/study/study.dart';

final class StudyRepositoryImpl implements StudyRepository {
  const StudyRepositoryImpl({
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
        await _studyLocalDataSource.getQuestionList(techId);

    if (cacheQuestionsModel != null) {
      final lastUpdateDate =
          await _studyRemoteDataSource.getLastQuestionsUpdateDate(techId);
      if (lastUpdateDate.compareTo(cacheQuestionsModel.updateDate) == 0) {
        questionsModel = cacheQuestionsModel;
      } else {
        questionsModel = await _studyRemoteDataSource.getQuestionList(techId);
      }
    } else {
      questionsModel = await _studyRemoteDataSource.getQuestionList(techId);
    }

    return Result.success(
      StudyQuestionListEntity.fromModel(questionsModel),
    );
  }
}
