import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/features/study_contents/repositories/entities/summary_entity.dart';
import 'package:techtalk/features/study_contents/repositories/enums/contents_language.enum.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skill_entity.dart';
import 'package:techtalk/features/topic/repositories/entities/qna_entity.dart';

/// 앱에서 학습을 위해 제공하는 컨텐츠의 상세 정보
abstract interface class ContentsDetailEntity {
  /// 특정 컨텐츠의 id
  final String id;

  /// 컨텐츠 타이틀
  final String title;

  /// 관련 기술 스킬
  final Set<SkillEntity> relatedSkills;

  /// 관련 직군
  final Set<JobGroup> relatedJobs;

  /// 컨텐츠 언어
  final Set<ContentsLanguage> contentsLanguage;

  /// 생성된 관련 질문
  final List<QnaEntity> relatedQna;

  /// 생성된 컨텐츠 요약
  final SummaryEntity summary;

  ContentsDetailEntity({
    required this.id,
    required this.title,
    required this.relatedSkills,
    required this.relatedJobs,
    required this.contentsLanguage,
    required this.relatedQna,
    required this.summary,
  });
}
