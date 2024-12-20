// import 'dart:async';
//
// import 'package:techtalk/core/index.dart';
// import 'package:techtalk/features/tech_set/repositories/entities/skill_set_entity.dart';
// import 'package:techtalk/features/tech_set/tech_set.dart';
//
// final class GetCachedSkillsUseCase
//     extends BaseNoParamUseCase<List<SkillSetEntity>> {
//   @override
//   Future<List<SkillSetEntity>> call() async {
//
//     final getSkillsKey = await techSetRepository.getKeys();
//     final remoteSkillKey = getSkillsKey.getOrThrow()..skillKey;
//
//     final getLocalSkills = await techSetRepository.getSkills();
//
//
//     // final needRemoteFetch = skillKey
//
//   }
// }
