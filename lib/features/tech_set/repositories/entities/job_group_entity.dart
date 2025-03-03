import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/features/tech_set/data_source/remote/model/job_group_model.dart';

final class JobGroupEntity {
  final String id;
  final String name;
  final int youtubeContentCount;

  const JobGroupEntity({
    required this.id,
    required this.name,
    required this.youtubeContentCount,
  });

  factory JobGroupEntity.fromModel(JobGroupModel model) => JobGroupEntity(
        id: model.id,
        name: AppLocale.isKo ? model.koName : model.name,
        youtubeContentCount: AppLocale.isKo
            ? model.youtubeContentCountKo
            : model.youtubeContentCount,
      );

  factory JobGroupEntity.fromEnum(JobGroupTypes type) => JobGroupEntity(
        id: type.id,
        name: AppLocale.isEn ? type.enName : type.name,
        youtubeContentCount: 0,
      );

  /// 1.0.12
  /// 마이그레이션 이후 존재하지 않은 skill일 경우 사용
  static String undefinedKey = 'undefined';

  factory JobGroupEntity.undefined() => JobGroupEntity(
        id: undefinedKey,
        name: undefinedKey,
        youtubeContentCount: 0,
      );

  bool get isUndefined => id == undefinedKey;
}
