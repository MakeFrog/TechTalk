import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/features/youtube/index.dart';

final class YoutubeAiQnaAndIdsResponse {
  /// 분석 타입
  final YoutubeContentAnalyzedType type;

  /// 모범답변
  final Set<YoutubeQnaEntity> qnas;

  /// 직군
  final Set<JobGroup> jogGroups;

  /// 스킬
  final Set<SkillEntity> skills;

  const YoutubeAiQnaAndIdsResponse({
    required this.type,
    required this.qnas,
    required this.jogGroups,
    required this.skills,
  });

  factory YoutubeAiQnaAndIdsResponse.fromJson(Map<String, dynamic> json) {
    return YoutubeAiQnaAndIdsResponse(
      type: YoutubeContentAnalyzedType.getById(json['type']),
      qnas: (json['qnas'] as List<dynamic>)
          .map((e) => YoutubeQnaEntity.fromJson(e))
          .toSet(),
      jogGroups: (json['jobGroupIds'] as List<dynamic>)
          .map((e) => JobGroup.getById(e))
          .toSet(),
      skills: (json['skillIds'] as List<dynamic>)
          .map((e) => techSetRepository.getSkillById(e))
          .toSet(),
    );
  }
}
