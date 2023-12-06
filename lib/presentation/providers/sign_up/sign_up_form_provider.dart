import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/job/entities/job_group_entity.dart';
import 'package:techtalk/features/skill/entities/skill_entity.dart';
import 'package:techtalk/features/user/entities/sign_up_form_entity.dart';
import 'package:techtalk/features/user/entities/user_data_entity.dart';
import 'package:techtalk/presentation/providers/user/user_auth_provider.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

part 'sign_up_form_provider.g.dart';

@Riverpod(keepAlive: true)
class SignUpForm extends _$SignUpForm {
  @override
  SignUpFormEntity build() => SignUpFormEntity();

  void updateNickname(String value) => state = state.copyWith(
        nickname: value,
      );

  void updateJobGroup(List<JobGroupEntity> value) => state = state.copyWith(
        jobGroupList: value,
      );

  void addJobGroup(JobGroupEntity group) {
    final isExist = state.jobGroups.contains(group);

    if (!isExist) {
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
      final selectedJobGroupList = List.of(state.jobGroups)..remove(group);

      state = state.copyWith(
        jobGroupList: selectedJobGroupList,
      );
    }
  }

  void addSkill(SkillEntity skill) {
    final isExist = state.skills.contains(skill);

    if (!isExist) {
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
      final selectedTechSkillList = List.of(state.skills)..remove(skill);

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
      interestedJobGroupIdList: state.jobGroups.map((e) => e.id).toList(),
      techSkillIdList: state.skills.map((e) => e.id).toList(),
    );

    await ref.read(userDataProvider.notifier).createUserData(userData);
  }
}
