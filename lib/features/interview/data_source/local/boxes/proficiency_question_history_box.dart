import 'package:hive/hive.dart';

part 'proficiency_question_history_box.g.dart';

///
/// 역량 면접 프로세스에서 생성된
/// 면접 질문 리스트
///

@HiveType(typeId: 5)
class ProficiencyQuestionHistoryBox extends HiveObject {
  /// 스킬
  @HiveField(0)
  final List<Map<String, List<String>>> skillQuestionSet;

  // 직군
  @HiveField(1)
  final List<Map<String, List<String>>> jobGroupQuestionSet;

  ProficiencyQuestionHistoryBox(
      {required this.skillQuestionSet, required this.jobGroupQuestionSet});

  ProficiencyQuestionHistoryBox copyWith({
    List<Map<String, List<String>>>? skillQuestionSet,
    List<Map<String, List<String>>>? jobGroupQuestionSet,
  }) {
    return ProficiencyQuestionHistoryBox(
      skillQuestionSet: skillQuestionSet ?? this.skillQuestionSet,
      jobGroupQuestionSet: jobGroupQuestionSet ?? this.jobGroupQuestionSet,
    );
  }
}
