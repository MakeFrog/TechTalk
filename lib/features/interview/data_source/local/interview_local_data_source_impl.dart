import 'package:hive_flutter/hive_flutter.dart';
import 'package:techtalk/features/interview/data_source/local/boxes/proficiency_question_history_box.dart';
import 'package:techtalk/features/interview/data_source/local/interview_local_data_source.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';

final class InterviewLocalDataSourceImpl extends InterviewLocalDataSource {
  InterviewLocalDataSourceImpl(this._box);

  final Box<ProficiencyQuestionHistoryBox> _box;

  @override
  List<Map<JobGroupEntity, List<String>>> getJobGroupQuestionHistory() {
    final box = _box.get('proficiency_question_history');
    if (box == null) return [];

    return box.jobGroupQuestionSet.map((jobGroupMap) {
      return jobGroupMap.map((key, value) {
        final jobGroup = JobGroupEntity.fromMap({
          'id': key,
          'name': value.first,
          'youtubeContentCount': 0,
        });
        return MapEntry(jobGroup, value.sublist(1));
      });
    }).toList();
  }

  @override
  List<Map<SkillEntity, List<String>>> getSkillQuestionHistory() {
    final box = _box.get('proficiency_question_history');
    if (box == null) return [];

    return box.skillQuestionSet.map((skillMap) {
      return skillMap.map((key, value) {
        final skill = SkillEntity.fromJson(
          json: {'name': key},
          category: value.first,
        );
        return MapEntry(skill, value.sublist(1));
      });
    }).toList();
  }

  @override
  Future<void> storeTechSetQuestionHistory<T extends TechSetEntity>(
      List<Map<T, List<String>>> history) async {
    final box = _box.get('proficiency_question_history') ??
        ProficiencyQuestionHistoryBox(
          skillQuestionSet: [],
          jobGroupQuestionSet: [],
        );

    // 기존 데이터 가져오기
    final existingSkillQuestionSet =
        List<Map<String, List<String>>>.from(box.skillQuestionSet);
    final existingJobGroupQuestionSet =
        List<Map<String, List<String>>>.from(box.jobGroupQuestionSet);

    // 기존 데이터를 Map으로 변환하여 쉽게 접근할 수 있도록 함
    final skillMap = Map<String, List<String>>.fromEntries(
      existingSkillQuestionSet.expand((map) => map.entries),
    );
    final jobGroupMap = Map<String, List<String>>.fromEntries(
      existingJobGroupQuestionSet.expand((map) => map.entries),
    );

    // 새로운 데이터 처리
    for (final techSetMap in history) {
      for (final entry in techSetMap.entries) {
        final key = entry.key;
        final value = entry.value;

        if (key is SkillEntity) {
          skillMap[key.id] = [key.category.name, ...value];
        } else if (key is JobGroupEntity) {
          jobGroupMap[key.id] = [key.name, ...value];
        }
      }
    }

    // Map을 다시 List<Map> 형태로 변환
    final updatedSkillQuestionSet =
        skillMap.entries.map((entry) => {entry.key: entry.value}).toList();
    final updatedJobGroupQuestionSet =
        jobGroupMap.entries.map((entry) => {entry.key: entry.value}).toList();

    await _box.put(
      'proficiency_question_history',
      box.copyWith(
        skillQuestionSet: updatedSkillQuestionSet,
        jobGroupQuestionSet: updatedJobGroupQuestionSet,
      ),
    );
  }
}
