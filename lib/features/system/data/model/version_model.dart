import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'version_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class VersionModel {
  VersionModel({required this.isSystemAvailable, required this.versionCode});

  final bool isSystemAvailable;
  final String versionCode;

  factory VersionModel.fromJson(Map<String, dynamic> json) =>
      _$VersionModelFromJson(json);

  factory VersionModel.fromFirestore(
          DocumentSnapshot snapshot, SnapshotOptions? options) =>
      VersionModel.fromJson(snapshot.data() as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$VersionModelToJson(this);
}
