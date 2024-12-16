import 'package:techtalk/app/di/modules/system_di.dart';
import 'package:techtalk/core/helper/string_extension.dart';

class SkillSetEntity {
  final String id;
  final String name;
  final String category;
  final String imagePath;

  SkillSetEntity(
      {required this.id,
      required this.name,
      required this.imagePath,
      required this.category});

  SkillSetEntity.fromJson(Map<String, dynamic> json)
      : id = (json['name'] as String).skillNameToId,
        name = json['name'] as String,
        category = json['category'] as String,
        imagePath =
            '${(json['name'] as String).skillNameToId.replaceAll('+', 'plus').replaceAll('#', 'sharp')}.png';
}
