import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/string_extension.dart';

part 'skill_text_field_controller_provider.g.dart';

@riverpod
class SkillTextFieldController extends _$SkillTextFieldController {
  @override
  Raw<TextEditingController> build() {
    return TextEditingController();
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
