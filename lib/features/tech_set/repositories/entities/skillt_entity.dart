import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/tech_set/data_source/remote/model/skill_model.dart';
import 'package:techtalk/features/tech_set/repositories/enums/skill_category.enum.dart';

class SkillEntity {
  final String id;
  final String name;
  final SkillCategory category;
  final String imagePath;
  final int youtubeContentCount;

  SkillEntity({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.category,
    required this.youtubeContentCount,
  });

  SkillEntity.fromJson(
      {required Map<String, dynamic> json, required String category})
      : id = (json['name'] as String).skillNameToId,
        name = json['name'] as String,
        category = SkillCategory.fromKey(category),
        imagePath = '${(json['name'] as String).skillNameToId}.png',
        youtubeContentCount = 0;

  factory SkillEntity.fromModel(SkillModel model) {
    return SkillEntity(
      id: model.name.skillNameToId,
      name: AppLocale.isKo ? model.name : model.koName,
      youtubeContentCount: AppLocale.isKo
          ? model.youtubeContentCountKo
          : model.youtubeContentCount,
      imagePath: '${model.name.skillNameToId}.png',
      category: SkillCategory.fromKey(
        model.category,
      ),
    );
  }

  /// 1.0.12
  /// 마이그레이션 이후 존재하지 않은 skill일 경우 사용
  static String undefinedKey = 'undefined';

  factory SkillEntity.undefined() => SkillEntity(
        id: undefinedKey,
        name: undefinedKey,
        imagePath: undefinedKey,
        category: SkillCategory.none,
        youtubeContentCount: 0,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
    };
  }

  bool get isUndefined => id == SkillEntity.undefinedKey;
}
