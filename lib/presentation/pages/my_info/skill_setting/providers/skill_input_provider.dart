import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/string_extension.dart';

part 'skill_input_provider.g.dart';

@riverpod
class SkillInput extends _$SkillInput {
  @override
  String build() {
    return '';
  }

  void update(String input) {
    state = input;
  }

  void clear() {
    state = '';
  }

  String? skillInputValidation(String? input) {
    if (input == null) {
      return '스킬을 검색해주세요';
    } else if (input.containsKorean) {
      return '영어로 스킬을 검색해주세요.';
    } else if (input.replaceAll(' ', '') != '' && !input.startsWithEnglish) {
      return '검색된 결과가 없습니다';
    } else {
      return null;
    }
  }
}
