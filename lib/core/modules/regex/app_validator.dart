abstract class AppValidator {
  ///
  /// 유튜브 url인지 여부
  ///
  static bool isYoutubeUrl(String? url) {
    if (url == null) return false;
    final regex = RegExp(
      r'^(https?:\/\/)?(www\.)?(youtube\.com\/(watch\?v=|embed\/|v\/|shorts\/)|youtu\.be\/)[a-zA-Z0-9_-]{11}(&[^\s]*)?$',
    );
    return regex.hasMatch(url);
  }

  ///
  /// URL 여부
  ///
  static bool isValidUrl(String? url) {
    if (url == null) return false;
    final regex = RegExp(r'^(https?:\/\/)?' // http:// 또는 https:// (옵션)
        r'([\w-]+\.)+[\w-]+' // 도메인 이름
        r'(:\d+)?' // 포트 번호 (옵션)
        r'(\/[^\s]*)?$' // 경로 및 쿼리 파라미터 (옵션)
        );
    return regex.hasMatch(url);
  }
}
