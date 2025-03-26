import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

part 'searched_skills_provider.g.dart';

@riverpod
class SearchedSkills extends _$SearchedSkills {
  @override
  List<SkillEntity> build() {
    return [];
  }

  void updateSearchedList(String searchedTerm) async {
    if (searchedTerm.containsKorean ||
        searchedTerm.replaceAll(' ', '').isEmpty) {
      state = [];
      return;
    }

    final response = getSearchedSkillSetUseCase.call(searchedTerm);
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
