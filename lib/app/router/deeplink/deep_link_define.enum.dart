// 스키마
enum DeeplinkScheme {
  techtalk;
}

/// 호스트
enum DeeplinkHost {
  landing, // 앱 내 페이지로 이동, techtalk://landing/main/detail?id=123
  prefixHomeLanding, // 앱 내 페이지로 이동, techtalk://prefix-home-landing/detail?id=123
  prefixYoutubeLanding, // 앱 내 페이지로 이동, techtalk://prefix-youtube-landing/detail?id=123
  externalLanding, // 외부 페이지로 이동 techtalk://detail/detail?id=123  execute, // 특정 메소드를 실행  techtalk://execute/save  newFeature, // 버전 업데이트 권유 techtalk://newFeature/1.3.4  undefined; // 정의되지 않은 값
  execute, // 특정 메소드를 실행
  newFeature, // 외부 페이지로 이동
  undefined;

  static DeeplinkHost getByHostName(String host) {
    return values.firstWhere(
      (e) => e.name.toLowerCase() == host.replaceAll('-', '').toLowerCase(),
      orElse: () => undefined,
    );
  }

  /// 특정 메인탭을 찍고가는 딥링크 여부
  bool get hasPrefixLandingProgress =>
      this == DeeplinkHost.prefixHomeLanding ||
      this == DeeplinkHost.prefixYoutubeLanding;
}
