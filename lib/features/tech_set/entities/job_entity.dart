class JobEntity {
  final String id;
  final String name;

//<editor-fold desc="Data Methods">
  const JobEntity({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JobEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'JobGroupEntity{' + ' id: $id,' + ' name: $name,' + '}';
  }

  JobEntity copyWith({
    String? id,
    String? name,
  }) {
    return JobEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

//</editor-fold>
}
