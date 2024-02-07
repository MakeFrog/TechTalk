import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/features/system/system.dart';

part 'version_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class VersionModel {
  VersionModel({required this.isSystemAvailable, required this.versionCode});

  final bool isSystemAvailable;
  final String versionCode;

  VersionEntity toEntity() => VersionEntity(
        versionCode: versionCode,
        isSystemAvailable: isSystemAvailable,
      );

  factory VersionModel.fromFirestore(
          DocumentSnapshot snapshot, SnapshotOptions? options) =>
      VersionModel.fromJson(snapshot.data() as Map<String, dynamic>);

  factory VersionModel.fromJson(Map<String, dynamic> json) =>
      _$VersionModelFromJson(json);

  Map<String, dynamic> toJson() => _$VersionModelToJson(this);
}
