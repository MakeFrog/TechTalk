abstract interface class SystemLocalDataSource {
  ///
  /// 마지막으로 설정된 locale language code 정보 호출
  ///
  Future<String?> loadLocaleLanguageCode();

  ///
  /// 현재 유저의 locale 정보 호출
  ///
  Future<void> storeLocaleCode(String code);
}
