import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/validation_extension.dart';
import 'package:techtalk/features/job/models/job_group_model.dart';
import 'package:techtalk/features/sign_up/entities/sign_up_form_entity.dart';
import 'package:techtalk/features/tech_skill/tech_skill.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/providers/app_user_data_provider.dart';

part 'sign_up_form_provider.g.dart';

@riverpod
class SignUpForm extends _$SignUpForm {
  final _isExistNicknameUseCase = GetIt.I<IsExistNicknameUseCase>();
  final _createUserDataUseCase = GetIt.I<CreateUserDataUseCase>();

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

    String? validationMessage;

    if (nickname.hasSpace) {
      validationMessage = '닉네임에 공백이 포함되어 있습니다.';
    } else if (!nickname.hasProperCharacter ||
        nickname.hasContainOperationWord) {
      validationMessage = '닉네임은 한글, 알파벳, 숫자, 언더스코어(_), 하이픈(-)만 사용할 수 있습니다.';
    } else if (nickname.hasContainFWord) {
      validationMessage = '닉네임에 비속어가 포함되어 있습니다.';
    }

    if (validationMessage != null) {
      state = state.copyWith(
        nickname: null,
        nicknameValidation: validationMessage,
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

  void addJobGroup(JobGroupModel group) {
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

  void removeJobGroup(JobGroupModel group) {
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

    await _createUserDataUseCase(userData);
  }
}
