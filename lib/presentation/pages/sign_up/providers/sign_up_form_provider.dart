import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/sign_up/models/sign_up_form_model.dart';
import 'package:techtalk/features/sign_up/sign_up.dart';

part 'sign_up_form_provider.g.dart';

@riverpod
class SignUpForm extends _$SignUpForm {
  @override
  SignUpFormModel build() {
    return const SignUpFormModel();
  }

  Future<void> updateNickname(String nickname) async {
    // TODO : 닉네임 형식 벨리데이션 추가
    final isExist = await isExistNicknameUseCase(nickname);

    if (isExist) {
      state = state.copyWith(
        nickname: null,
        nicknameValidation: '중복된 닉네임입니다.',
      );
    } else {
      state = state.copyWith(
        nickname: nickname,
        nicknameValidation: null,
      );
    }
  }

  void clearNickname() {
    state = state.copyWith(
      nickname: null,
      nicknameValidation: null,
    );
  }
}
