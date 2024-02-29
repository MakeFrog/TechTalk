import 'package:korean_profanity_filter/korean_profanity_filter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/validation_extension.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

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
      return '닉네임을 입력해주세요';
    } else if (input.hasSpace) {
      return '닉네임에는 공백을 사용할 수 없습니다';
    } else if (input.trim().length < 2 || input.trim().length > 10) {
      return '닉네임은 2에서 10글자 사이여야 합니다';
    } else if (input.hasProperCharacter) {
      return '닉네임에는 한글, 알파벳, 숫자, 언더스코어(_), 하이픈(-)만 사용할 수 있습니다';
    } else if (input.containsBadWords) {
      return '비속어, 욕설 단어는 사용할 수 없습니다';
    } else if (input.hasContainOperationWord) {
      return '사용할 수 없는 닉네임 입니다';
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
