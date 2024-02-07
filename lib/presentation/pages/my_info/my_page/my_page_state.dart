import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/system/repositories/entities/version_entity.dart';
import 'package:techtalk/features/user/repositories/entities/user_entity.dart';
import 'package:techtalk/presentation/providers/system/app_version_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

mixin class MyPageState {
  ///
  /// 유저 정보
  ///
  AsyncValue<UserEntity?> user(WidgetRef ref) => ref.watch(userInfoProvider);

  ///
  /// 버전 정보
  ///
  AsyncValue<VersionEntity> version(WidgetRef ref) =>
      ref.watch(appVersionProvider);
}
