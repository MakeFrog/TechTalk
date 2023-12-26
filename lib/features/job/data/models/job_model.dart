import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/job/job.dart';

part 'job_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class JobModel {
  JobModel({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  JobEntity toEntity() => JobEntity(
        id: id,
        name: name,
      );

  factory JobModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      JobModel.fromJson(snapshot.data()!);

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return _$JobModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$JobModelToJson(this);
}
