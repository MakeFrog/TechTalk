import 'dart:ui';

import 'package:techtalk/core/constants/content_filter_category_type.enum.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';

///
/// 유튜브 컨텐츠 필터 카테고리 모델
/// [JobGroup][SkillEntity] 2가지 모델을 모두 호환하기 위함.
///
final class YoutubeContentFiler {
  final String id;
  final String name;
  final ContentFilterCategoryType type;
  final String? imagePath;

  const YoutubeContentFiler({
    required this.id,
    required this.name,
    required this.type,
    this.imagePath,
  });

  factory YoutubeContentFiler.fromSkill(SkillEntity entity) =>
      YoutubeContentFiler(
        id: entity.id,
        name: entity.name,
        type: ContentFilterCategoryType.skill,
        imagePath: entity.imagePath,
      );

  factory YoutubeContentFiler.fromJob(JobGroup job) => YoutubeContentFiler(
        id: job.id,
        name: job.name,
        type: ContentFilterCategoryType.jobGroup,
      );
}
