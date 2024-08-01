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
          DocumentSnapshot snapshot, SnapshotOptions? options) {
    final data = snapshot.data() as Map<String, dynamic>;
    return VersionModel.fromJson(data);
  }

  factory VersionModel.fromJson(Map<String, dynamic> json) {
    return VersionModel(
      isSystemAvailable: json['is_system_available'] as bool? ?? false,
      needUpdate: json['need_update'] as bool? ?? false,
      versionCode: json['version_code'] as String? ?? '',
      notification: json['notification'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => _$VersionModelToJson(this);
}
