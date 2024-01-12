import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/features/tech_set/entities/skill_entity.dart';
import 'package:techtalk/presentation/pages/my_info/job_group_setting/provider/selected_job_groups_provider.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/searched_skills_provider.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/skill_input_provider.dart';

mixin class SignUpState {
  ///
  /// 선택된 직군
  ///
  List<JobGroup> selectedJobGroups(WidgetRef ref) =>
      ref.watch(selectedJobGroupsProvider);

  ///
  /// 선택된 직군이 조재 여부
  ///
  bool isJobGroupSelectionFilled(WidgetRef ref) =>
      ref.watch(selectedJobGroupsProvider).isNotEmpty;

  ///
  /// 검색된 스킬 리스트
  ///
  List<SkillEntity> skills(WidgetRef ref) => ref.watch(searchedSkillsProvider);

  ///
  /// 검색어
  ///
  String searchedTerm(WidgetRef ref) => ref.watch(skillInputProvider);
}
