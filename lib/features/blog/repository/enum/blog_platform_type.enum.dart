enum BlogPlatformType {
  owned, // 자체 블로그
  medium, // 미디엄
  tistory, // 티스토리
  velog, // 벨로그
  undefined;

  static BlogPlatformType getById(String id) => values.firstWhere(
        (type) => type.name == id,
        orElse: () => BlogPlatformType.undefined,
      );
}
