import 'package:techtalk/features/system/repositories/entities/version_entity.dart';

final class AppVersion {
  static final AppVersion _instance = AppVersion._internal();

  factory AppVersion() => _instance;

  AppVersion._internal();

  VersionEntity? to;

  void initialize(VersionEntity version) {
    to = version;
  }

  bool get isOnReview => to?.isOnReview ?? false;
}
