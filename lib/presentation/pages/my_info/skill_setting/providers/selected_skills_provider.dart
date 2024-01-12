import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/services/snack_bar_servbice.dart';
import 'package:techtalk/features/tech_set/entities/skill_entity.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

part 'selected_skills_provider.g.dart';

@riverpod
class SelectedSkills extends _$SelectedSkills {
  @override
  List<SkillEntity> build() {
    final userSkills = ref.read(userDataProvider).value!.skills;
    return userSkills.toList();
  }

  void add(SkillEntity item) {
    if (state.contains(item)) {
      SnackBarService.showSnackBar('이미 선택된 기술입니다.');
      return;
    }
    state = [...state, item];
  }

  void removeAt(int index) {
    final removeList = state..removeAt(index);
    state = [...removeList];
  }
}
