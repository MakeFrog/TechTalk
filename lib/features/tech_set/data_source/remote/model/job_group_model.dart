import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_group_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class JobGroupModel {
  final String id;
  final String name;
  final String koName;
  final int youtubeContentCount;
  final int youtubeContentCountKo;
  final int blogContentCount;
  final int blogContentCountKo;

  const JobGroupModel({
    required this.name,
    required this.koName,
    required this.id,
    required this.youtubeContentCount,
    required this.youtubeContentCountKo,
    required this.blogContentCount,
    required this.blogContentCountKo,
  });

  factory JobGroupModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      JobGroupModel.fromJson(snapshot.data()!);

  factory JobGroupModel.fromJson(Map<String, dynamic> json) {
    return _$JobGroupModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$JobGroupModelToJson(this);
}
