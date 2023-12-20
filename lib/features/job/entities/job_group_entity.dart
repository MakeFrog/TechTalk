import 'package:techtalk/features/job/data/models/job_group_model.dart';

class JobGroupEntity {
  final String id;
  final String name;

//<editor-fold desc="Data Methods">
  const JobGroupEntity({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JobGroupEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'JobGroupEntity{' + ' id: $id,' + ' name: $name,' + '}';
  }

  JobGroupEntity copyWith({
    String? id,
    String? name,
  }) {
    return JobGroupEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory JobGroupEntity.fromModel(JobGroupModel model) {
    return JobGroupEntity(
      id: model.id,
      name: model.name,
    );
  }

//</editor-fold>
}
