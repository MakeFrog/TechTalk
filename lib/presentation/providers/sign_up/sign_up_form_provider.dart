import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/validation_extension.dart';
import 'package:techtalk/features/job/entities/job_group_entity.dart';
import 'package:techtalk/features/skill/entities/skill_entity.dart';
import 'package:techtalk/features/user/entities/sign_up_form_entity.dart';
import 'package:techtalk/features/user/entities/user_data_entity.dart';
import 'package:techtalk/presentation/providers/user/auth/user_auth_provider.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

part 'sign_up_form_provider.g.dart';

@Riverpod(keepAlive: true)
class SignUpForm extends _$SignUpForm {
  @override
  SignUpFormEntity build() => SignUpFormEntity();

  void updateNickname(String value) => state = SignUpFormEntity(
        nickname: value,
        nicknameValidation: _validateNickname(value),
      );

  void updateNicknameValidation(String value) => state = SignUpFormEntity(
        nickname: state.nickname,
        nicknameValidation: value,
      );

  String? _validateNickname(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (value.hasSpace) {
      return '닉네임에 공백이 포함되어 있습니다.';
    } else if (!value.hasProperCharacter) {
      return '닉네임은 한글, 알파벳, 숫자, 언더스코어(_), 하이픈(-)만 사용할 수 있습니다.';
    } else if (value.hasContainFWord) {
      return '닉네임에 비속어가 포함되어 있습니다.';
    } else if (value.hasContainOperationWord) {
      return '허용되지 않는 단어가 포함되어 있습니다.';
    } else {
      return null;
    }
  }

  void addJobGroup(JobGroupEntity group) {
    final isNotExist = !state.jobGroups.contains(group);

    if (isNotExist) {
      state = state.copyWith(
        jobGroupList: [
          ...state.jobGroups,
          group,
        ],
      );
    }
  }

  void removeJobGroup(JobGroupEntity group) {
    final isExist = state.jobGroups.contains(group);

    if (isExist) {
      state = state.copyWith(
        jobGroupList: [...state.jobGroups]..remove(group),
      );
    }
  }

  void addSkill(SkillEntity skill) {
    final isNotExist = !state.skills.contains(skill);

    if (isNotExist) {
      state = state.copyWith(
        techSkillList: [
          ...state.skills,
          skill,
        ],
      );
    }
  }

  void removeSkill(SkillEntity skill) {
    final isExist = state.skills.contains(skill);

    if (isExist) {
      state = state.copyWith(
        techSkillList: [...state.skills]..remove(skill),
      );
    }
  }

  Future<void> submit() async {
    final userUid = ref.read(userAuthProvider)!.uid;

    final userData = UserDataEntity(
      uid: userUid,
      nickname: state.nickname,
      interestedJobGroupIdList: [...state.jobGroups.map((e) => e.id)],
      techSkillIdList: [...state.skills.map((e) => e.id)],
    );

    await ref.read(userDataProvider.notifier).createUserData(userData);
  }
}
