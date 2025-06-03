import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/interview/data_source/local/interview_local_data_source.dart';
import 'package:techtalk/features/interview/repository/interview_repository.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'dart:developer' as developer;

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
      developer.log('getJobGroupQuestionHistory 에러: $e');
      return Result.success([]); // 에러 발생 시 빈 배열 반환
    }
  }

  @override
  Result<List<Map<SkillEntity, List<String>>>> getSkillQuestionHistory() {
    try {
      final history = _localDataSource.getSkillQuestionHistory();
      return Result.success(history);
    } catch (e) {
      developer.log('getSkillQuestionHistory 에러: $e');
      return Result.success([]); // 에러 발생 시 빈 배열 반환
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
      developer.log('storeTechSetQuestionHistory 에러: $e');
      return Result.success(null); // 에러 발생 시에도 성공 처리
    }
  }

  List<Map<T, List<String>>> _limitQuestionCount<T extends TechSetEntity>(
      List<Map<T, List<String>>> history) {
    try {
      // 기존 질문들 가져오기
      List<Map<SkillEntity, List<String>>> existingSkillHistory = [];
      List<Map<JobGroupEntity, List<String>>> existingJobGroupHistory = [];

      try {
        existingSkillHistory = _localDataSource.getSkillQuestionHistory();
      } catch (e) {
        developer.log('스킬 히스토리 로드 실패: $e');
      }

      try {
        existingJobGroupHistory = _localDataSource.getJobGroupQuestionHistory();
      } catch (e) {
        developer.log('직군 히스토리 로드 실패: $e');
      }

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
    } catch (e) {
      developer.log('_limitQuestionCount 에러: $e');
      return []; // 에러 발생 시 빈 배열 반환
    }
  }
}
