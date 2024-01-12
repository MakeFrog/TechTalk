class SkillEntity {
  final String id;
  final String name;

  SkillEntity({required this.id, required this.name});

  SkillEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkillEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'SkillEntity{id: $id, name: $name}';
  }
}
