import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/core/services/snack_bar_service.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';

part 'selected_tech_sets_provider.g.dart';

@riverpod
class SelectedTechSets extends _$SelectedTechSets {
  @override
  List<TechSetEntity> build() {
    return [];
  }

  void addList(List<TechSetEntity> techSets) {
    final targetTechSets = techSets;
    techSets.addAll(state);
    final filteredTechSets = targetTechSets.toSet().toList();
    state = filteredTechSets;
  }

  void remove(TechSetEntity techSet) {
    final targetTechSets = state.toList();
    targetTechSets.removeWhere((e) => e == techSet);
    state = targetTechSets;
  }

  bool addItem(TechSetEntity techSet) {
    if (state.firstWhereOrNull((e) => e == techSet) != null) {
      HapticFeedback.vibrate();
      SnackBarService.showSnackBar('이미 선택된 항목입니다');

      return false;
    }

    if (state.length >= 4) {
      HapticFeedback.vibrate();
      SnackBarService.showSnackBar(
        tr(
          LocaleKeys.interview_maxFourQuestions,
          namedArgs: {
            'number': '${4}',
          },
        ),
      );
      return false;
    }

    final targetTechSets = state.toList();
    targetTechSets.add(techSet);
    state = targetTechSets;
    return true;
  }
}
