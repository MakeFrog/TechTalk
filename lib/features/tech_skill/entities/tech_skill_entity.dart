import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/features/tech_skill/data/models/tech_skill_model.dart';

part 'tech_skill_entity.freezed.dart';
part 'tech_skill_entity.g.dart';

@freezed
class TechSkillEntity with _$TechSkillEntity {
  const factory TechSkillEntity({
    required String id,
    required String name,
  }) = _TechSkillEntity;

  factory TechSkillEntity.fromModel(TechSkillModel model) {
    return TechSkillEntity(
      id: model.id,
      name: model.name,
    );
  }

  factory TechSkillEntity.fromJson(Map<String, dynamic> json) =>
      _$TechSkillEntityFromJson(json);
}
