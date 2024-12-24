abstract final class AppFormatHandler {
  ///
  /// 스킬 리스트 json을 변화할 떄 사용하는메소드
  ///
  static Map<String, List<Map<String, String>>> parseMapSLMaSSJson(
      Map<String, dynamic> jsonData) {
    return jsonData.map((key, value) {
      return MapEntry(
        key,
        List<Map<String, String>>.from(
          value.map((item) => Map<String, String>.from(item)),
        ),
      );
    });
  }
}
