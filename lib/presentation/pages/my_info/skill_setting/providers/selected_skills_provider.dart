import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/core/services/snack_bar_service.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/presentation/providers/scroll/selected_skill_scroll_controller.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

part 'selected_skills_provider.g.dart';

@riverpod
class SelectedSkills extends _$SelectedSkills {
  @override
  List<SkillEntity> build() {
    final userSkills = ref.read(userInfoProvider).value?.skills;
    return userSkills?.toList() ?? [];
  }

  void add(SkillEntity item) {
    if (state.contains(item)) {
      SnackBarService.showSnackBar(tr(LocaleKeys.common_alreadySelected));
      return;
    }
    state = [...state, item];
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        final scrollController =
            ref.read(selectedSkillScrollControllerProvider);
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
