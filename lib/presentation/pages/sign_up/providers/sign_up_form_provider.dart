import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/job/models/job_group_model.dart';
import 'package:techtalk/features/sign_up/models/sign_up_form_model.dart';
import 'package:techtalk/features/sign_up/sign_up.dart';

part 'sign_up_form_provider.g.dart';

@riverpod
class SignUpForm extends _$SignUpForm {
  @override
  SignUpFormModel build() => const SignUpFormModel();

  Future<void> updateNickname(String nickname) async {
    if (nickname.isEmpty) {
      state = state.copyWith(
        nickname: null,
        nicknameValidation: null,
      );
      return;
    }

    // TODO : 중복여부 검사 전 닉네임 형식 벨리데이션 추가
    final isExist = await locator<IsExistNicknameUseCase>()(nickname);

    state = isExist
        ? state.copyWith(
            nickname: null,
            nicknameValidation: '중복된 닉네임입니다.',
          )
        : state.copyWith(
            nickname: nickname,
            nicknameValidation: null,
          );
  }

  void addJobGroup(JobGroupModel jobGroup) {
    state = state.copyWith(
      selectedJobGroupList: [
        ...state.selectedJobGroupList,
        jobGroup,
      ],
    );
  }

  void removeJobGroup(int index) {
    final selectedJobGroupList = List.of(state.selectedJobGroupList)
      ..removeAt(index);

    state = state.copyWith(
      selectedJobGroupList: selectedJobGroupList,
    );
  }
}
