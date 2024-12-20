import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/features/tech_set/repositories/enums/skill_category.enum.dart';

class SkillSetEntity {
  final String id;
  final String name;
  final SkillCategory category;
  final String imagePath;

  SkillSetEntity(
      {required this.id,
      required this.name,
      required this.imagePath,
      required this.category});

  SkillSetEntity.fromJson(
      {required Map<String, dynamic> json, required String category})
      : id = (json['name'] as String).skillNameToId,
        name = json['name'] as String,
        category = SkillCategory.fromKey(category),
        imagePath =
            '${(json['name'] as String).skillNameToId.replaceAll('+', 'plus').replaceAll('#', 'sharp')}.png';

  // factory SkillSetEntity.fromBoxModel({
  //   required SkillItemModel item,
  //   required String categoryName,
  // }) {
  //   return SkillSetEntity(
  //     id: item.name.skillNameToId,
  //     name: item.name,
  //     imagePath:
  //         '${item.name.skillNameToId.replaceAll('+', 'plus').replaceAll('#', 'sharp')}.png',
  //     category: SkillCategory.fromKey(categoryName),
  //   );
  // }
}
