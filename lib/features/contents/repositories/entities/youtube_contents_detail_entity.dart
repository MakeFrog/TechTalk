import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_contents_detail_model.dart';
import 'package:techtalk/features/contents/repositories/entities/summary_entity.dart';
import 'package:techtalk/features/contents/repositories/enums/contents_language.enum.dart';

/// 앱에서 학습을 위해 제공하는 컨텐츠의 상세 정보
class YoutubeContentsDetailEntity {
  /// 특정 컨텐츠의 id - 외부 값에 의존하지 않는 고유 id
  final String id;

  /// 해당 컨텐츠의 아이디

  /// 컨텐츠 타이틀
  final String title;

  /// NOTE: 저자 정보인데, 유튜브 api에서 channel 정보의 ID와 동일하다
  /// 우선은 id만 저장하고, 추가적인 논의 필요
  final String authorId;

  /// 관련 기술 스킬
  final Set<String> relatedSkillIds;

  /// 관련 직군
  final Set<JobGroup> relatedJobs;

  /// 컨텐츠 언어
  final Set<ContentsLanguage> contentsLanguage;

  /// 생성된 컨텐츠 요약
  final SummaryEntity summary;

  /// 콘텐츠가 처음 테크톡에 업로드 된 날짜
  final DateTime uploadAt;

  /// 콘텐츠가 만들어진 날짜
  final DateTime createdAt;

  /// 컨텐츠를 업로드 한 유저 아이디
  final String? uploadUserId;

  YoutubeContentsDetailEntity({
    required this.id,
    required this.title,
    required this.authorId,
    required this.relatedSkillIds,
    required this.relatedJobs,
    required this.contentsLanguage,
    required this.summary,
    required this.createdAt,
    required this.uploadAt,
    this.uploadUserId,
  });

  YoutubeContentsDetailModel toModel() => YoutubeContentsDetailModel(
        id: id,
        title: title,
        authorId: authorId,
        relatedSkillIds: relatedSkillIds.toList(),
        relatedJobGroupIds: relatedJobs.map((job) => job.id).toList(),
        contentsLanguageIds: contentsLanguage.map((language) => language.id).toList(),
        summary: summary.toModel(),
        createdAt: createdAt,
        uploadAt: uploadAt,
        uploadUserId: uploadUserId,
      );
}
