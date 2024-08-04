import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
  /// 현재 앱 버전
  ///
  Future<String> currentAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
