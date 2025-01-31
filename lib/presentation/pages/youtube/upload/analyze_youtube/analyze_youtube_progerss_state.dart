import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/providers/system/notification_status_provider.dart';

mixin class AnalyzeYoutubeProgressState {
  ///
  /// 알람 권한 허용 여부
  ///
  AsyncValue<bool> isNotificationGranted(WidgetRef ref) =>
      ref.watch(notificationStatusProvider);
}
