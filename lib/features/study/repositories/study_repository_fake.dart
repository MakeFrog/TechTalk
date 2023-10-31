import 'package:techtalk/features/study/entities/study_question_list_entity.dart';
import 'package:techtalk/features/study/study.dart';

final class StudyRepositoryFake implements StudyRepository {
  const StudyRepositoryFake(this._studyRemoteDataSource);

  final StudyRemoteDataSource _studyRemoteDataSource;

  @override
  Future<StudyQuestionListEntity> getQuestionList() async {
    final questionListModel = await _studyRemoteDataSource.getQuestionList();

    return StudyQuestionListEntity.fromModel(questionListModel);
  }
}
