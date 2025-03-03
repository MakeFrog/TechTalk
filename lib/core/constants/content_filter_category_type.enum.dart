///
/// 콘텐츠(yotubue) 카테고리 타입
///
enum ContentFilterCategoryType {
  all(''),
  jobGroup('related_job_group_ids'),
  skill('related_skill_ids');

  /// firestore document 필드명
  final String documentFieldName;

  const ContentFilterCategoryType(this.documentFieldName);

  bool get isAll => this == ContentFilterCategoryType.all;
  bool get isJobGroup => this == ContentFilterCategoryType.jobGroup;
  bool get isSkill => this == ContentFilterCategoryType.skill;
}
