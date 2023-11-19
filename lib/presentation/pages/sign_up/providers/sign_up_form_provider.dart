import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/validation_extension.dart';
import 'package:techtalk/features/job/entities/job_group_entity.dart';
import 'package:techtalk/features/sign_up/entities/sign_up_form_entity.dart';
import 'package:techtalk/features/sign_up/sign_up.dart';
import 'package:techtalk/features/tech_skill/tech_skill.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/providers/app_user_data_provider.dart';

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
      state = state.copyWith(
        nickname: null,
        nicknameValidation: null,
      );
      return;
    }

    final validationMessage = _validateNickname(nickname);
    if (validationMessage != null) {
      state = state.copyWith(
        nickname: null,
        nicknameValidation: validationMessage,
      );

      return;
    }

    final result = await isNicknameDuplicatedUseCase(nickname);
    state = result.getOrThrow()
        ? state.copyWith(
            nickname: null,
            nicknameValidation: '중복된 닉네임입니다.',
          )
        : state.copyWith(
            nickname: nickname,
            nicknameValidation: null,
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

  void addTechSkill(TechSkillEntity skill) {
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

  void removeTechSkill(TechSkillEntity skill) {
    final isExist = state.techSkillList.contains(skill);

    if (isExist) {
      final selectedTechSkillList = List.of(state.techSkillList)..remove(skill);

      state = state.copyWith(
        techSkillList: selectedTechSkillList,
      );
    }
  }

  Future<void> submit() async {
    final userData = ref.read(appUserDataProvider).requireValue!.copyWith(
          nickname: state.nickname,
          interestedJobGroupIdList:
              state.jobGroupList.map((e) => e.id).toList(),
          techSkillIdList: state.techSkillList.map((e) => e.id).toList(),
        );

    await createUserDataUseCase(userData);
  }
}
