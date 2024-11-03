import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/features/contents/repositories/entities/contents_author_entity.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skill_entity.dart';

///
/// 컨텐츠의 오버뷰 정보, 리스트 같은 곳에서 보기 위함
///
/// 오버뷰는 리스트 형식으로 노출하기 떄문에, 다양한 타입의 클래스를 다룰 여지가 있다고 판단하여
/// sealed class 로 선언
///
sealed class ContentsOverviewEntity {
  /// 아이디
  final String id;

  /// 컨텐츠 아이디
  final String contentsId;

  /// 컨텐츠 썸네일 이미지 url
  final String thumbnailImgUrl;

  /// 컨텐츠 타이틀
  final String contentsTitle;

  /// 컨텐츠에서 생성된 질문 개수 - gpt로 돌리지 않은 컨텐츠면 기본 0
  final int qnaNum;

  /// 컨텐츠 저자 정보
  final ContentsAuthorEntity author;

  /// 관련 기술 스킬
  final Set<SkillEntity> relatedSkills;

  /// 관련 직군
  final Set<JobGroup> relatedJobs;

  ContentsOverviewEntity({
    required this.id,
    required this.contentsId,
    required this.thumbnailImgUrl,
    required this.contentsTitle,
    required this.author,
    required this.relatedJobs,
    required this.relatedSkills,
    this.qnaNum = 0,
  });
}

class VideoContentsOverviewEntity implements ContentsOverviewEntity {
  @override
  final String id;

  @override
  final String contentsId;

  @override
  final String thumbnailImgUrl;

  @override
  final String contentsTitle;

  @override
  final int qnaNum; // 아직 등록되지 않은 비디오면 0이 기본값

  @override
  final ContentsAuthorEntity author;

  @override
  final Set<SkillEntity> relatedSkills;

  /// 관련 직군
  @override
  final Set<JobGroup> relatedJobs;

  final int? viewCount;

  final Duration videoDuration;

  VideoContentsOverviewEntity({
    required this.id,
    required this.contentsId,
    required this.thumbnailImgUrl,
    required this.contentsTitle,
    required this.author,
    required this.relatedJobs,
    required this.relatedSkills,
    required this.videoDuration,
    this.viewCount,
    this.qnaNum = 0,
  });
}
