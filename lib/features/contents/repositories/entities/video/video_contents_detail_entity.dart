import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/features/contents/repositories/entities/interface/contents_detail_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/summary_entity.dart';
import 'package:techtalk/features/contents/repositories/enums/contents_language.enum.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skill_entity.dart';
import 'package:techtalk/features/topic/repositories/entities/qna_entity.dart';
import 'package:techtalk/features/user/repositories/entities/user_entity.dart';

/// 비디오 컨텐츠의 상세 정보
class VideoContentsDetailEntity implements ContentsDetailEntity {
  @override
  final String id;

  @override
  final String title;

  @override
  final Set<SkillEntity> relatedSkills;

  @override
  final Set<JobGroup> relatedJobs;

  @override
  final Set<ContentsLanguage> contentsLanguage;

  @override
  final SummaryEntity summary;

  @override
  final List<QnaEntity> relatedQna;

  /// 비디오를 업로드 한 유저의 정보
  final UserEntity? uploadUser;

  /// 관련된 비디오의 아이디
  final String videoId;

  VideoContentsDetailEntity({
    required this.id,
    required this.videoId,
    required this.title,
    required this.relatedSkills,
    required this.relatedJobs,
    required this.contentsLanguage,
    required this.relatedQna,
    required this.summary,
    this.uploadUser,
  });
}
