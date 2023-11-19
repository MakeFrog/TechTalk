import 'package:techtalk/features/study/data/models/study_question_list_model.dart';

abstract interface class StudyRemoteDataSource {
  Future<StudyQuestionListModel> getQuestionList(String techId);

  Future<DateTime> getLastQuestionsUpdateDate(String techId);
}
