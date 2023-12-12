import 'package:techtalk/features/job/data/models/job_group_list_model.dart';
import 'package:techtalk/features/job/job.dart';

class JobGroupListEntity {
  final int totalCount;
  final List<JobGroupEntity> groups;

//<editor-fold desc="Data Methods">
  const JobGroupListEntity({
    required this.totalCount,
    required this.groups,
  });

  factory JobGroupListEntity.fromModel(JobGroupListModel model) {
    return JobGroupListEntity(
      totalCount: model.totalCount,
      groups: model.groups.map(JobGroupEntity.fromModel).toList(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JobGroupListEntity &&
          runtimeType == other.runtimeType &&
          totalCount == other.totalCount &&
          groups == other.groups);

  @override
  int get hashCode => totalCount.hashCode ^ groups.hashCode;

  @override
  String toString() {
    return 'JobGroupListEntity{' +
        ' totalCount: $totalCount,' +
        ' groups: $groups,' +
        '}';
  }

  JobGroupListEntity copyWith({
    int? totalCount,
    List<JobGroupEntity>? groups,
  }) {
    return JobGroupListEntity(
      totalCount: totalCount ?? this.totalCount,
      groups: groups ?? this.groups,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalCount': this.totalCount,
      'groups': this.groups,
    };
  }

  factory JobGroupListEntity.fromMap(Map<String, dynamic> map) {
    return JobGroupListEntity(
      totalCount: map['totalCount'] as int,
      groups: map['groups'] as List<JobGroupEntity>,
    );
  }

//</editor-fold>
}
