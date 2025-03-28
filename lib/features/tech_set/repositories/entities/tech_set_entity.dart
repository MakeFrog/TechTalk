import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/tech_set/data_source/remote/model/job_group_model.dart';
import 'package:techtalk/features/tech_set/data_source/remote/model/skill_model.dart';
import 'package:techtalk/features/tech_set/repositories/enums/skill_category.enum.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

sealed class TechSetEntity {
  final String id;    
  final String name;

  TechSetEntity({required this.id, required this.name});

  static TechSetEntity mappedFromId(String id) {
    /// 1. 스킬 매핑
    final targetSkill = techSetRepository.getSkillById(id);
    if (targetSkill.id != SkillEntity.undefinedKey) {
      return targetSkill;
    } else {
      /// 스킬에서 매핑된게 없으면
      /// 2. 직군 매핑
      final targetJobGroup = techSetRepository.getJobGroupById(id);
      return targetJobGroup;
    }
  }
}

// abstract class TechSetEntity {
//   static TechSetEntity skill<T>(SkillEntity skill) => SkillSet(skill);
//
//   static TechSetEntity jobGroup<T>(JobGroupEntity jobGroup) =>
//       JobGroupSet(jobGroup);
//
//   static TechSetEntity mappedFromId(String id) {
//     /// 1. 스킬 매핑
//     final targetSkill = techSetRepository.getSkillById(id);
//     if (targetSkill.id != SkillEntity.undefinedKey) {
//       return SkillSet(targetSkill);
//     } else {
//       /// 스킬에서 매핑된게 없으면
//       /// 2. 직군 매핑
//       final targetJobGroup = techSetRepository.getJobGroupById(id);
//       return JobGroupSet(targetJobGroup);
//     }
//   }
//
//   String id() {
//     return this is SkillSet
//         ? (this as SkillSet).value.id
//         : (this as JobGroupSet).value.id;
//   }
//
//   String name() {
//     return this is SkillSet
//         ? (this as SkillSet).value.name
//         : (this as JobGroupSet).value.name;
//   }
//
//   R fold<R>({
//     required R Function(SkillEntity value) skill,
//     required R Function(JobGroupEntity e) jobGroup,
//   }) {
//     return this is SkillSet
//         ? skill((this as SkillSet).value)
//         : jobGroup((this as JobGroupSet).value);
//   }
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     return other is TechSetEntity && other.id() == id();
//   }
//
//   @override
//   int get hashCode => id().hashCode;
// }

class SkillEntity extends TechSetEntity {
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
  }) : super(id: id, name: name);

  factory SkillEntity.fromJson(
      {required Map<String, dynamic> json, required String category}) {
    return SkillEntity(
      id: (json['name'] as String).skillNameToId,
      name: json['name'] as String,
      imagePath: '${(json['name'] as String).skillNameToId}.png',
      category: SkillCategory.fromKey(category),
      youtubeContentCount: 0,
    );
  }

  factory SkillEntity.fromModel(SkillModel model) {
    return SkillEntity(
      id: model.name.skillNameToId,
      name: AppLocale.isKo ? model.koName : model.name,
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

  factory SkillEntity.fromId(String id) {
    final target = techSetRepository.getSkillById(id);
    return target;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }

  bool get isUndefined => id == SkillEntity.undefinedKey;
}

final class JobGroupEntity extends TechSetEntity {
  final String id;
  final String name;
  final int youtubeContentCount;

  JobGroupEntity({
    required this.id,
    required this.name,
    required this.youtubeContentCount,
  }) : super(id: id, name: name);

  factory JobGroupEntity.fromModel(JobGroupModel model) => JobGroupEntity(
        id: model.id,
        name: AppLocale.isKo ? model.koName : model.name,
        youtubeContentCount: AppLocale.isKo
            ? model.youtubeContentCountKo
            : model.youtubeContentCount,
      );

  factory JobGroupEntity.fromEnum(JobGroupTypes type) => JobGroupEntity(
        id: type.id,
        name: AppLocale.isEn ? type.enName : type.name,
        youtubeContentCount: 0,
      );

  /// 1.0.12
  /// 마이그레이션 이후 존재하지 않은 skill일 경우 사용
  static String undefinedKey = 'undefined';

  factory JobGroupEntity.undefined() => JobGroupEntity(
        id: undefinedKey,
        name: undefinedKey,
        youtubeContentCount: 0,
      );

  bool get isUndefined => id == undefinedKey;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }

  factory JobGroupEntity.fromMap(Map<String, dynamic> map) {
    return JobGroupEntity(
      id: map['id'] as String,
      name: map['name'] as String,
      youtubeContentCount: map['youtubeContentCount'] as int,
    );
  }

  factory JobGroupEntity.fromId(String id) {
    final target = techSetRepository.getJobGroupById(id);
    return target;
  }
}
