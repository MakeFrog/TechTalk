import 'package:pub_semver/pub_semver.dart';
import 'package:techtalk/features/system/data_source/remote/models/version_model.dart';
import 'package:techtalk/features/system/repositories/entities/youtube_gpt_model_type.enum.dart';

class VersionEntity {
  /// 최소 버전
  final Version minVersion;

  /// 심사중인 버전
  final Version onGoingReviewVersion;

  /// 현재 버전
  final Version currentVersion;

  final String notification;

  /// 유튜브섹션에서 사용되는 gpt 모델
  final YoutubeGptModelType youtubeGptModel;

  /// 현재 리뷰중인 버전인지 여부
  final bool isSystemAvailable;
  final bool needUpdate;

  /// 현재 심사중인 버전이라면
  bool get isOnReview => onGoingReviewVersion == currentVersion;

  const VersionEntity({
    required this.minVersion,
    required this.youtubeGptModel,
    required this.onGoingReviewVersion,
    required this.notification,
    required this.currentVersion,
    required this.isSystemAvailable,
    required this.needUpdate,
  });

  factory VersionEntity.fromModel(
    VersionModel model, {
    required String currentVersion,
  }) {
    return VersionEntity(
      needUpdate: model.needUpdate,
      notification: model.notification,
      isSystemAvailable: model.isSystemAvailable,
      minVersion: Version.parse(model.versionCode),
      currentVersion: Version.parse(currentVersion),
      onGoingReviewVersion: Version.parse(model.ongoingAppReviewVersion),
      youtubeGptModel: YoutubeGptModelType.getById(model.youtubeGptModel),
    );
  }

  VersionEntity copyWith({
    Version? minVersion,
    Version? onGoingReviewVersion,
    Version? currentVersion,
    String? notification,
    YoutubeGptModelType? youtubeGptModel,
    bool? isSystemAvailable,
    bool? needUpdate,
  }) {
    return VersionEntity(
      minVersion: minVersion ?? this.minVersion,
      onGoingReviewVersion: onGoingReviewVersion ?? this.onGoingReviewVersion,
      currentVersion: currentVersion ?? this.currentVersion,
      notification: notification ?? this.notification,
      youtubeGptModel: youtubeGptModel ?? this.youtubeGptModel,
      isSystemAvailable: isSystemAvailable ?? this.isSystemAvailable,
      needUpdate: needUpdate ?? this.needUpdate,
    );
  }
}
