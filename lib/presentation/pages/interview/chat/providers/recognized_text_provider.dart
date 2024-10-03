import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recognized_text_provider.g.dart';

@riverpod
class RecognizedText extends _$RecognizedText {
  @override
  String build() => ''; // 초기 값으로 빈 문자열

  void update(String newText) {
    state = newText;
  }
}
