import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';

abstract class InterviewLocalDataSource {
  /// 직군 관련 면접 질문 리스트 호출
  List<Map<JobGroupEntity, List<String>>> getJobGroupQuestionHistory();

  /// 스킬 관련 면접 질문 리스트 호출
  List<Map<SkillEntity, List<String>>> getSkillQuestionHistory();

  Future<void> storeTechSetQuestionHistory<T extends TechSetEntity>(
      List<Map<T, List<String>>> history);
}
