import 'package:techtalk/features/system/data/model/version_model.dart';

class VersionEntity {
  final String versionCode;
  final bool isSystemAvailable;

  const VersionEntity({
    required this.versionCode,
    required this.isSystemAvailable,
  });

  factory VersionEntity.fromModel(VersionModel model) => VersionEntity(
      versionCode: model.versionCode,
      isSystemAvailable: model.isSystemAvailable);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VersionEntity &&
          runtimeType == other.runtimeType &&
          versionCode == other.versionCode &&
          isSystemAvailable == other.isSystemAvailable);

  @override
  int get hashCode => versionCode.hashCode ^ isSystemAvailable.hashCode;

  @override
  String toString() {
    return 'VersionEntity{' +
        ' versionCode: $versionCode,' +
        ' isSystemAvailable: $isSystemAvailable,' +
        '}';
  }

  VersionEntity copyWith({
    String? versionCode,
    bool? isSystemAvailable,
  }) {
    return VersionEntity(
      versionCode: versionCode ?? this.versionCode,
      isSystemAvailable: isSystemAvailable ?? this.isSystemAvailable,
    );
  }
}
