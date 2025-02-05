import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:techtalk/features/user/repositories/entities/document_entity.dart';
import 'package:techtalk/features/user/repositories/entities/user_entity.dart';
import 'package:techtalk/presentation/pages/resume_manage/providers/resume_info_provider.dart';
import 'package:techtalk/presentation/providers/system/notification_status_provider.dart';
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

  ///
  /// 알람 권한 허용 여부
  ///
  AsyncValue<bool> isNotificationGranted(WidgetRef ref) =>
      ref.watch(notificationStatusProvider);

  ///
  /// 이력서 로컬 데이터 불러오기
  ///
  DocumentEntity loadDocumentData(WidgetRef ref) =>
      ref.watch(resumeInfoProvider).requireValue!;

  ///
  /// 이력서 엔티티 정보
  ///
  AsyncValue<DocumentEntity?> resumeAsync(WidgetRef ref) =>
      ref.watch(resumeInfoProvider);

  ///
  /// 이력서 데이터 유무 판별
  ///
  bool hasData(WidgetRef ref) =>
      ref.read(resumeInfoProvider.notifier).hasData();
}
