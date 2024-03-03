import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/services/snack_bar_service.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

part 'selected_skills_provider.g.dart';

@riverpod
class SelectedSkills extends _$SelectedSkills {
  @override
  List<SkillEntity> build() {
    final userSkills = ref.read(userInfoProvider).value?.skills;
    return userSkills?.toList() ?? [];
  }

  void add(SkillEntity item, ScrollController scrollController) {
    if (state.contains(item)) {
      SnackBarService.showSnackBar('이미 선택된 기술입니다.');
      return;
    }
    state = [...state, item];
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 260),
          curve: Curves.fastOutSlowIn,
        );
      },
    );
  }

  void removeAt(int index) {
    final removeList = state..removeAt(index);
    state = [...removeList];
  }
}
