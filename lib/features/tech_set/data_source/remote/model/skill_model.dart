import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'skill_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SkillModel {
  final String name;
  final String koName;

  final String category;
  final int youtubeContentCount;
  final int youtubeContentCountKo;
  final int blogContentCount;
  final int blogContentCountKo;

  SkillModel({
    required this.name,
    required this.koName,
    required this.category,
    required this.youtubeContentCount,
    required this.youtubeContentCountKo,
    required this.blogContentCount,
    required this.blogContentCountKo,
  });

  factory SkillModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      SkillModel.fromJson(snapshot.data()!);

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return _$SkillModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SkillModelToJson(this);
}
