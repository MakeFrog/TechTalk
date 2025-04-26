import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/interview/data_source/local/interview_local_data_source.dart';
import 'package:techtalk/features/interview/repository/interview_repository.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';

final class InterviewRepositoryImpl extends InterviewRepository {
  InterviewRepositoryImpl(this._localDataSource);

  final InterviewLocalDataSource _localDataSource;

  static const int _maxQuestionCount = 10;

  @override
  Result<List<Map<JobGroupEntity, List<String>>>> getJobGroupQuestionHistory() {
    try {
      final history = _localDataSource.getJobGroupQuestionHistory();
      return Result.success(history);
    } catch (e) {
      return Result.failure(e as Exception);
    }
  }

  @override
  Result<List<Map<SkillEntity, List<String>>>> getSkillQuestionHistory() {
    try {
      final history = _localDataSource.getSkillQuestionHistory();
      return Result.success(history);
    } catch (e) {
      return Result.failure(e as Exception);
    }
  }

  @override
  Future<Result<void>> storeTechSetQuestionHistory<T extends TechSetEntity>(
      List<Map<T, List<String>>> history) async {
    try {
      final limitedHistory = _limitQuestionCount(history);
      await _localDataSource.storeTechSetQuestionHistory(limitedHistory);
      return Result.success(null);
    } catch (e) {
      return Result.failure(e as Exception);
    }
  }

  List<Map<T, List<String>>> _limitQuestionCount<T extends TechSetEntity>(
      List<Map<T, List<String>>> history) {
    // 기존 질문들 가져오기
    final existingSkillHistory = _localDataSource.getSkillQuestionHistory();
    final existingJobGroupHistory =
        _localDataSource.getJobGroupQuestionHistory();
    Map<String, List<String>> existingQuestionsMap = {};

    // 스킬 질문 맵에 추가
    for (final skillMap in existingSkillHistory) {
      for (final entry in skillMap.entries) {
        existingQuestionsMap[entry.key.id] = entry.value;
      }
    }

    // 직군 질문 맵에 추가
    for (final jobGroupMap in existingJobGroupHistory) {
      for (final entry in jobGroupMap.entries) {
        existingQuestionsMap[entry.key.id] = entry.value;
      }
    }

    return history.map((techSetMap) {
      return techSetMap.map((key, value) {
        // 해당 TechSetEntity의 기존 질문들 가져오기
        final existingQuestions = existingQuestionsMap[key.id] ?? [];

        // 새로운 질문들과 기존 질문들 합치기
        final combinedQuestions = [...existingQuestions, ...value];

        // 최대 10개로 제한 (가장 오래된 것부터 제거)
        final limitedQuestions = combinedQuestions.length > _maxQuestionCount
            ? combinedQuestions
                .sublist(combinedQuestions.length - _maxQuestionCount)
            : combinedQuestions;

        return MapEntry(key, limitedQuestions);
      });
    }).toList();
  }
}
