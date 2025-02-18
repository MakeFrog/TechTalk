///
/// 등록된 이력서 설정 타입 종류.
/// [ResumeManagePage] 섹션에서 사용됨.
///

enum ResumeSettingType {
  upload('변경'),
  preview('미리보기'),
  delete('삭제');

  final String nameTrKey;

  const ResumeSettingType(this.nameTrKey);

  static ResumeSettingType getByIndex(int index) => values.firstWhere(
        (type) => type.index == index,
        orElse: () => throw Exception('InCorrect Index : $index'),
      );

  static R branch<R>({
    required ResumeSettingType targetCategory,
    required R Function(ResumeSettingType) upload,
    required R Function(ResumeSettingType) preview,
    required R Function(ResumeSettingType) delete,
  }) {
    switch (targetCategory) {
      case ResumeSettingType.upload:
        return upload(targetCategory);
      case ResumeSettingType.preview:
        return preview(targetCategory);
      case ResumeSettingType.delete:
        return delete(targetCategory);
      default:
        throw Exception('InCorrect Resume Setting Type: $targetCategory');
    }
  }
}
