import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/features/system/system.dart';

part 'version_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class VersionModel {
  VersionModel({
    required this.isSystemAvailable,
    required this.needUpdate,
    required this.versionCode,
    required this.notification,
  });

  final bool isSystemAvailable;
  final bool needUpdate;
  final String versionCode;
  final String notification;

  VersionEntity toEntity() => VersionEntity(
        needUpdate: needUpdate,
        notification: notification,
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
