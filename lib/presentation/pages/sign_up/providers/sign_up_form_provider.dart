import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/job/models/job_group_model.dart';
import 'package:techtalk/features/sign_up/entities/sign_up_form_entity.dart';
import 'package:techtalk/features/sign_up/sign_up.dart';

part 'sign_up_form_provider.g.dart';

@riverpod
class SignUpForm extends _$SignUpForm {
  final _isExistNicknameUseCase = locator<IsExistNicknameUseCase>();

  @override
  SignUpFormEntity build() => const SignUpFormEntity();

  Future<void> updateNickname(String nickname) async {
    if (nickname.isEmpty) {
      state = state.copyWith(
        nickname: null,
        nicknameValidation: null,
      );
      return;
    }

    // TODO : 중복여부 검사 전 닉네임 형식 벨리데이션 추가
    final isExist = await _isExistNicknameUseCase(nickname);

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
    if (!state.selectedJobGroupList.contains(jobGroup)) {
      state = state.copyWith(
        selectedJobGroupList: [
          ...state.selectedJobGroupList,
          jobGroup,
        ],
      );
    }
  }

  void removeJobGroup(int index) {
    final removeTarget = state.selectedJobGroupList.elementAtOrNull(index);

    if (removeTarget != null) {
      final selectedJobGroupList = List.of(state.selectedJobGroupList)
        ..removeAt(index);

      state = state.copyWith(
        selectedJobGroupList: selectedJobGroupList,
      );
    }
  }
}
