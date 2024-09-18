abstract interface class SystemLocalDataSource {
  ///
  /// 마지막으로 설정된 locale language code 정보 호출
  ///
  Future<String?> loadLocaleLanguageCode();

  ///
  /// 현재 유저의 locale 정보 호출
  ///
  Future<void> storeLocaleCode(String code);

  ///
  /// 디바이이스 가상 키보드 높이 호출
  ///
  Future<double?> loadKeyboardHeight();

  ///
  /// 가상 키보드 높이 저장
  ///
  Future<void> storeKeyboardHeight(double height);
}
