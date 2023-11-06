import 'package:techtalk/features/study/entities/study_question_list_entity.dart';

abstract interface class StudyRepository {
  Future<StudyQuestionListEntity> getQuestionList();
}
