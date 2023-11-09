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
    StudyQuestionListModel? questionsModel =
        await _studyLocalDataSource.getQuestionList(techId);

    // 캐시 데이터가 존재하지 않을때는 바로 원격 데이터를 요청, 반환
    if (questionsModel == null) {
      questionsModel = await _studyRemoteDataSource.getQuestionList(techId);

      return Result.success(
        StudyQuestionListEntity.fromModel(questionsModel),
      );
    }

    // 업데이트 날짜를 비교하여 최신이 아니면 최신 데이터 조회,캐시 업데이트 후 반환
    final lastUpdateDate =
        await _studyRemoteDataSource.getLastQuestionsUpdateDate(techId);
    if (lastUpdateDate.compareTo(questionsModel.updateDate) != 0) {
      questionsModel = await _studyRemoteDataSource.getQuestionList(techId);
    }

    return Result.success(
      StudyQuestionListEntity.fromModel(questionsModel),
    );
  }
}
