import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/validation_extension.dart';

part 'sign_up_nickname_provider.g.dart';

@riverpod
class SignUpNickname extends _$SignUpNickname {
  @override
  String? build() {
    return null;
  }

  void updateState(String? value) => state = value;

  Future<bool> checkDuplication() async {
    // TODO : check nickname duplication

    return false;
  }
}

@riverpod
class SignUpNicknameValidation extends _$SignUpNicknameValidation {
  @override
  String? build() {
    final nickname = ref.watch(signUpNicknameProvider);

    return _validate(nickname);
  }

  String? _validate(String? nickname) {
    if (nickname == null || nickname.isEmpty) {
      return null;
    } else if (nickname.hasSpace) {
      return '닉네임에 공백이 포함되어 있습니다.';
    } else if (!nickname.hasProperCharacter) {
      return '닉네임은 한글, 알파벳, 숫자, 언더스코어(_), 하이픈(-)만 사용할 수 있습니다.';
    } else if (nickname.hasContainFWord) {
      return '닉네임에 비속어가 포함되어 있습니다.';
    } else if (nickname.hasContainOperationWord) {
      return '허용되지 않는 단어가 포함되어 있습니다.';
    } else {
      return null;
    }
  }

  void updateState(String value) => state = value;
}
