import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';

abstract class InterviewRepository {
  /// 직군별 질문 히스토리를 가져옵니다.
  Result<List<Map<JobGroupEntity, List<String>>>> getJobGroupQuestionHistory();

  /// 스킬별 질문 히스토리를 가져옵니다.
  Result<List<Map<SkillEntity, List<String>>>> getSkillQuestionHistory();

  /// TechSet별 질문 히스토리를 저장합니다.
  Future<Result<void>> storeTechSetQuestionHistory<T extends TechSetEntity>(
      List<Map<T, List<String>>> history);
}
