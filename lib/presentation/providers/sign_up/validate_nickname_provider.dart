import 'package:flutter_animate/flutter_animate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/riverpod_extension.dart';
import 'package:techtalk/core/helper/validation_extension.dart';
import 'package:techtalk/features/user/user.dart';

part 'validate_nickname_provider.g.dart';

@riverpod
Future<String?> validateNickname(
  ValidateNicknameRef ref,
  String nickname,
) async {
  if (nickname.isEmpty) return null;

  await ref.execDebounce(1.seconds);

  String? validationMessage;

  if (nickname.hasSpace) {
    validationMessage = '닉네임에 공백이 포함되어 있습니다.';
  } else if (!nickname.hasProperCharacter) {
    validationMessage = '닉네임은 한글, 알파벳, 숫자, 언더스코어(_), 하이픈(-)만 사용할 수 있습니다.';
  } else if (nickname.hasContainFWord) {
    validationMessage = '닉네임에 비속어가 포함되어 있습니다.';
  } else if (nickname.hasContainOperationWord) {
    validationMessage = '허용되지 않는 단어가 포함되어 있습니다.';
  }

  if (validationMessage != null) {
    return validationMessage;
  }

  final result = await isExistNicknameUseCase(nickname);
  validationMessage = result.getOrThrow() ? '중복된 닉네임입니다.' : null;

  return validationMessage;
}
