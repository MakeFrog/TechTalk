import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/features/tech_set/repositories/enums/skill_category.enum.dart';

class SkillEntity {
  final String id;
  final String name;
  final SkillCategory category;
  final String imagePath;

  SkillEntity(
      {required this.id,
      required this.name,
      required this.imagePath,
      required this.category});

  SkillEntity.fromJson(
      {required Map<String, dynamic> json, required String category})
      : id = (json['name'] as String).skillNameToId,
        name = json['name'] as String,
        category = SkillCategory.fromKey(category),
        imagePath =
            '${(json['name'] as String).skillNameToId.replaceAll('+', 'plus').replaceAll('#', 'sharp')}.png';

  /// 1.0.12
  /// 마이그레이션 이후 존재하지 않은 skill일 경우 사용
  static String undefinedKey = 'undefined';

  factory SkillEntity.undefined() => SkillEntity(
        id: undefinedKey,
        name: undefinedKey,
        imagePath: undefinedKey,
        category: SkillCategory.none,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
    };
  }

  factory SkillEntity.fromMap(Map<String, dynamic> map) {
    return SkillEntity(
      id: map['id'] as String,
      name: map['name'] as String,
      category: map['category'] as SkillCategory,
      imagePath: map['imagePath'] as String,
    );
  }
}
