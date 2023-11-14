import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/study/study.dart';

final class GetStudyQuestionListUseCase {
  const GetStudyQuestionListUseCase(
    this._studyRepository,
  );

  final StudyRepository _studyRepository;

  Future<Result<StudyQuestionListEntity>> call(String techId) async {
    return _studyRepository.getQuestionList(techId);
  }
}
