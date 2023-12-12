import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/skill/entities/skill_list_entity.dart';
import 'package:techtalk/features/skill/skill.dart';

part 'searched_tech_skill_list_provider.g.dart';

@riverpod
class TechSkillSearchKeyword extends _$TechSkillSearchKeyword {
  @override
  String build() {
    return '';
  }

  set keyword(String value) => state = value;
}

@riverpod
Future<SkillListEntity> searchedTechSkillList(
  SearchedTechSkillListRef ref,
) async {
  final keyword = ref.watch(techSkillSearchKeywordProvider);

  if (keyword.isEmpty) {
    return SkillListEntity();
  }

  final skillList = await searchSkillsUseCase(keyword);

  return skillList.fold(
    onSuccess: (value) {
      final skills = value.skills;

      // if (!skills
      //     .map((e) => e.name.toLowerCase())
      //     .contains(keyword.toLowerCase())) {
      //   skills.insert(
      //     0,
      //     SkillEntity(
      //       id: '',
      //       name: keyword,
      //     ),
      //   );
      // }

      return value.copyWith(
        skills: skills,
      );
    },
    onFailure: (e) {
      throw e;
    },
  );
}
