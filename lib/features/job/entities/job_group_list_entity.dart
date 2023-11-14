import 'package:techtalk/features/job/job.dart';

class JobGroupListEntity {
  final List<JobGroupEntity> groups;

//<editor-fold desc="Data Methods">
  const JobGroupListEntity({
    required this.groups,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JobGroupListEntity &&
          runtimeType == other.runtimeType &&
          groups == other.groups);

  @override
  int get hashCode => groups.hashCode;

  @override
  String toString() {
    return 'JobGroupListEntity{' + ' groups: $groups,' + '}';
  }

  JobGroupListEntity copyWith({
    List<JobGroupEntity>? groups,
  }) {
    return JobGroupListEntity(
      groups: groups ?? this.groups,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'groups': this.groups,
    };
  }

  factory JobGroupListEntity.fromMap(Map<String, dynamic> map) {
    return JobGroupListEntity(
      groups: map['groups'] as List<JobGroupEntity>,
    );
  }

//</editor-fold>
}
