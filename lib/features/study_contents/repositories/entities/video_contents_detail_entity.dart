import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/features/study_contents/repositories/entities/interface/contents_detail_entity.dart';
import 'package:techtalk/features/study_contents/repositories/entities/summary_entity.dart';
import 'package:techtalk/features/study_contents/repositories/entities/video_contents_author_entity.dart';
import 'package:techtalk/features/study_contents/repositories/enums/contents_language.enum.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skill_entity.dart';
import 'package:techtalk/features/topic/repositories/entities/qna_entity.dart';
import 'package:techtalk/features/user/repositories/entities/user_entity.dart';

/// 비디오 컨텐츠의 상세 정보
class VideoContentsDetailEntity implements ContentsDetailEntity {
  @override
  String id;

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

  /// 비디오 컨텐츠의 저자
  final VideoContentsAuthorEntity author;

  /// 비디오 조회수
  final int views;

  /// 비디오 길이
  final Duration videoLength;

  /// 비디오 좋아요 수
  final int likes;

  /// 비디오를 업로드 한 유저의 정보
  final UserEntity? uploadUser;

  VideoContentsDetailEntity({
    required this.id,
    required this.title,
    required this.relatedSkills,
    required this.relatedJobs,
    required this.contentsLanguage,
    required this.relatedQna,
    required this.summary,
    required this.author,
    required this.views,
    required this.videoLength,
    required this.likes,
    this.uploadUser,
  });
}
