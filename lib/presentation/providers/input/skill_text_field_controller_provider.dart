import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/helper/string_extension.dart';

part 'skill_text_field_controller_provider.g.dart';

@riverpod
class SkillTextFieldController extends _$SkillTextFieldController {
  @override
  Raw<TextEditingController> build() {
    return TextEditingController();
  }

  String? skillInputValidation(String? input) {
    final currentContext = rootNavigatorKey.currentContext;
    if (rootNavigatorKey.currentContext == null) return '404';
    if (input == null) {
      return currentContext!.tr(LocaleKeys.jobSelection_needSearchKeyword);
    } else if (input.containsKorean) {
      return currentContext!.tr(LocaleKeys.jobSelection_needToSearchInEnglish);
    } else if (input.replaceAll(' ', '') != '' && !input.startsWithEnglish) {
      return currentContext!.tr(LocaleKeys.jobSelection_noResultFound);
    } else {
      return null;
    }
  }
}

// return 'Please search for a skill.';
// } else if (input.containsKorean) {
// return 'Please search for skills in English.';
// } else if (input.replaceAll(' ', '') != '' && !input.startsWithEnglish) {
// return 'No results found.';
