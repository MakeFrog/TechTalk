import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'version_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class VersionModel {
  VersionModel({
    this.isSystemAvailable = true,
    this.needUpdate = false,
    this.versionCode = '2.0.0',
    this.notification = '',
    this.ongoingAppReviewVersion = '2.0.0',
    this.youtubeGptModel = 'gpt-4o',
  });

  final bool isSystemAvailable;
  final bool needUpdate;
  final String versionCode;
  final String ongoingAppReviewVersion;
  final String youtubeGptModel;

  final String notification;

  factory VersionModel.fromFirestore(
      DocumentSnapshot snapshot, SnapshotOptions? options) {
    final data = snapshot.data() as Map<String, dynamic>;
    return VersionModel.fromJson(data);
  }

  factory VersionModel.fromJson(Map<String, dynamic> json) {
    return _$VersionModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VersionModelToJson(this);
}
