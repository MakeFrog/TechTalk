import 'package:korean_profanity_filter/korean_profanity_filter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/core/helper/validation_extension.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';
import 'package:easy_localization/easy_localization.dart';

part 'nickname_input_provider.g.dart';

@riverpod
class NicknameInput extends _$NicknameInput {
  @override
  String? build() {
    final userNickname = ref.watch(userInfoProvider).value?.nickname;
    return userNickname;
  }

  String? nickNameValidation([String? value]) {
    String? input = value ?? state;

    if (input == null || input == '') {
      return tr(LocaleKeys.onboarding_nickname_enterNickname);
    } else if (input.hasSpace) {
      return tr(LocaleKeys.onboarding_nickname_noSpacesAllowed);
    } else if (input.trim().length < 2 || input.trim().length > 10) {
      return tr(LocaleKeys.onboarding_nickname_nicknameLength);
    } else if (input.hasProperCharacter) {
      return tr(LocaleKeys.onboarding_nickname_invalidNickname);
    } else if (input.containsBadWords) {
      return tr(LocaleKeys.onboarding_nickname_profanityNotAllowed);
    } else if (input.hasContainOperationWord) {
      return tr(LocaleKeys.onboarding_nickname_invalidNickname);
    } else {
      return null;
    }
  }

  void clearInput() {
    state = '';
  }

  void onInputChanged(String? input) {
    state = input;
  }
}
