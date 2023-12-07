import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/skill/skill.dart';

part 'searched_skills_provider.g.dart';

@riverpod
Future<List<SkillEntity>> searchedSkills(
  SearchedSkillsRef ref, {
  String? keyword,
}) async {
  if (keyword == null || keyword.isEmpty) {
    return [];
  }

  final searchedSkillsResult = await searchSkillsUseCase(keyword);

  return searchedSkillsResult.skills;
}
