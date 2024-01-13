///
/// 프로필 설정 타입 종류.
/// [MyPage] 섹션에서 사용됨.
///

enum ProfileSettingType {
  basicProfile('프로필'),
  jobGroup('관심 직군'),
  topic('관심 주제');

  final String name;

  const ProfileSettingType(this.name);

  static ProfileSettingType getByIndex(int index) => values.firstWhere(
        (type) => type.index == index,
        orElse: () => throw Exception('InCorrect Index : $index'),
      );

  static R branch<R>({
    required ProfileSettingType targetCategory,
    required R Function(ProfileSettingType) profile,
    required R Function(ProfileSettingType) jobGroup,
    required R Function(ProfileSettingType) topic,
  }) {
    switch (targetCategory) {
      case ProfileSettingType.basicProfile:
        return profile(targetCategory);
      case ProfileSettingType.jobGroup:
        return jobGroup(targetCategory);
      case ProfileSettingType.topic:
        return topic(targetCategory);
      default:
        throw Exception('InCorrect Profile Setting Type: $targetCategory');
    }
  }
}
