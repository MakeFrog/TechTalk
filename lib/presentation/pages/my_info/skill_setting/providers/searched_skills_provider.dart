import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/tech_set/entities/skill_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/presentation/providers/input/skill_text_field_controller_provider.dart';

part 'searched_skills_provider.g.dart';

@riverpod
class SearchedSkills extends _$SearchedSkills {
  @override
  List<SkillEntity> build() {
    return [];
  }

  void updateSearchedList(String searchedTerm) {
    if (ref
                .read(skillTextFieldControllerProvider.notifier)
                .skillInputValidation(searchedTerm) !=
            null ||
        searchedTerm.replaceAll(' ', '').isEmpty) {
      state = [];

      return;
    }

    final response = getSearchedSkills.call(searchedTerm);
    response.fold(
      onSuccess: (e) {
        state = e;
      },
      onFailure: (e) {
        throw e;
      },
    );
  }

  void clear() {
    state = [];
  }
}
