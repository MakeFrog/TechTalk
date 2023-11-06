import 'package:techtalk/features/study/study.dart';

final class GetStudyQuestionListUseCase {
  const GetStudyQuestionListUseCase(
    this._studyRepository,
  );

  final StudyRepository _studyRepository;

  Future<StudyQuestionListEntity> call() async {
    return _studyRepository.getQuestionList();
  }
}
