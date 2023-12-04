import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/validation_extension.dart';
import 'package:techtalk/features/job/entities/job_group_entity.dart';
import 'package:techtalk/features/skill/entities/skill_entity.dart';
import 'package:techtalk/features/user/entities/sign_up_form_entity.dart';
import 'package:techtalk/features/user/entities/user_data_entity.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/providers/user/user_auth_provider.dart';

part 'sign_up_form_provider.g.dart';

@riverpod
class SignUpForm extends _$SignUpForm {
  @override
  SignUpFormEntity build() => SignUpFormEntity();

  String? _validateNickname(String nickname) {
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

    return validationMessage;
  }

  Future<void> updateNickname(String nickname) async {
    if (nickname.isEmpty) {
      clearNickname();
      return;
    }

    final validationMessage = _validateNickname(nickname);
    if (validationMessage != null) {
      state = state.copyWith(
        nickname: '',
        nicknameValidation: validationMessage,
      );

      return;
    }

    final result = await isExistNicknameUseCase(nickname);
    state = SignUpFormEntity(
      nickname: nickname,
      nicknameValidation: result.getOrThrow() ? '중복된 닉네임입니다.' : null,
      jobGroupList: state.jobGroupList,
      techSkillList: state.techSkillList,
    );
  }

  void clearNickname() {
    state = state.copyWith(
      nickname: '',
      nicknameValidation: '',
    );
  }

  void addJobGroup(JobGroupEntity group) {
    final isExist = state.jobGroupList.contains(group);

    if (!isExist) {
      state = state.copyWith(
        jobGroupList: [
          ...state.jobGroupList,
          group,
        ],
      );
    }
  }

  void removeJobGroup(JobGroupEntity group) {
    final isExist = state.jobGroupList.contains(group);

    if (isExist) {
      final selectedJobGroupList = List.of(state.jobGroupList)..remove(group);

      state = state.copyWith(
        jobGroupList: selectedJobGroupList,
      );
    }
  }

  void addSkill(SkillEntity skill) {
    final isExist = state.techSkillList.contains(skill);

    if (!isExist) {
      state = state.copyWith(
        techSkillList: [
          ...state.techSkillList,
          skill,
        ],
      );
    }
  }

  void removeSkill(SkillEntity skill) {
    final isExist = state.techSkillList.contains(skill);

    if (isExist) {
      final selectedTechSkillList = List.of(state.techSkillList)..remove(skill);

      state = state.copyWith(
        techSkillList: selectedTechSkillList,
      );
    }
  }

  Future<void> submit() async {
    final userUid = ref.read(userAuthProvider)!.uid;

    final userData = UserDataEntity(
      uid: userUid,
      nickname: state.nickname,
      interestedJobGroups: state.jobGroupList.map((e) => e.id).toList(),
      skills: state.techSkillList.map((e) => e.id).toList(),
    );

    await createUserDataUseCase(userData);
  }
}
