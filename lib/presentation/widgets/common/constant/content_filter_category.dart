import 'package:techtalk/core/constants/content_filter_category_type.enum.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';

///
/// 컨텐츠 필터 카테고리 모델
/// [JobGroup][SkillEntity] 2가지 모델을 모두 호환하기 위함.
///
final class ContentFilterCategory {
  final String id;
  final String name;
  final ContentFilterCategoryType type;
  final int contentCount;
  final String? imagePath;

  const ContentFilterCategory({
    required this.id,
    required this.name,
    required this.type,
    this.contentCount = 0,
    this.imagePath,
  });

  factory ContentFilterCategory.fromSkill(SkillEntity entity) =>
      ContentFilterCategory(
        id: entity.id,
        name: entity.name,
        type: ContentFilterCategoryType.skill,
        imagePath: entity.imagePath,
        contentCount: entity.youtubeContentCount,
      );

  factory ContentFilterCategory.fromJob(JobGroupEntity job) =>
      ContentFilterCategory(
        id: job.id,
        name: job.name,
        type: ContentFilterCategoryType.jobGroup,
        contentCount: job.youtubeContentCount,
      );

  factory ContentFilterCategory.fromSkillOrJobGroup(
          {JobGroupEntity? job, SkillEntity? skill}) =>
      ContentFilterCategory(
        id: job?.id ?? skill?.id ?? 'undefined',
        name: job?.name ?? skill?.name ?? '잘못된값',
        type: (job == null && skill == null)
            ? ContentFilterCategoryType.all
            : (job != null
                ? ContentFilterCategoryType.jobGroup
                : ContentFilterCategoryType.skill),
        contentCount:
            job?.youtubeContentCount ?? skill?.youtubeContentCount ?? 0,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentFilterCategory &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          type == other.type &&
          imagePath == other.imagePath;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ type.hashCode ^ imagePath.hashCode;
}
