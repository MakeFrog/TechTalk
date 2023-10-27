import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/tech_skill/tech_skill.dart';

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
Future<List<TechSkillEntity>> searchedTechSkillList(
  SearchedTechSkillListRef ref,
) async {
  final keyword = ref.watch(techSkillSearchKeywordProvider);

  if (keyword.isEmpty) {
    return [];
  }

  final techSkillList = await searchTechSkillListUseCase(keyword);

  return techSkillList;
}
