import 'package:techtalk/features/skill/data/models/skill_model.dart';

class SkillEntity {
  final String id;
  final String name;

//<editor-fold desc="Data Methods">
  const SkillEntity({
    required this.id,
    required this.name,
  });

  factory SkillEntity.fromModel(SkillModel model) {
    return SkillEntity(
      id: model.id,
      name: model.name,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkillEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'SkillEntity{' + ' id: $id,' + ' name: $name,' + '}';
  }

  SkillEntity copyWith({
    String? id,
    String? name,
  }) {
    return SkillEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }

  factory SkillEntity.fromMap(Map<String, dynamic> map) {
    return SkillEntity(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

//</editor-fold>
}
