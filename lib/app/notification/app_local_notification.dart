import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:techtalk/app/router/deeplink/deeplink_handler.dart';

final class AppLocalNotification {
  static final AppLocalNotification _instance =
      AppLocalNotification._internal();

  factory AppLocalNotification() => _instance;

  AppLocalNotification._internal();

  late final FlutterLocalNotificationsPlugin _local;

  Future<void> initialize() async {
    _local = FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings android =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    DarwinInitializationSettings ios = const DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    InitializationSettings settings =
        InitializationSettings(android: android, iOS: ios);
    await _local.initialize(
      settings,
      onDidReceiveNotificationResponse: notificationTapped,
      onDidReceiveBackgroundNotificationResponse: notificationTapped,
    );
  }

  /// 알림이 탭 되었을 때
  static void notificationTapped(NotificationResponse response) {
    DeepLinkHandler().handleDeepLink(response.payload ?? '');
  }

  Future<void> testShow() async {
    NotificationDetails details = const NotificationDetails(
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
      android: AndroidNotificationDetails(
        "1",
        "test",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await _local.show(
        1, "제목입니다", "본문이 이렇게 길거 들어갈 수 도 있느네 안리 수도 있다는 ㄴ말이죠", details,
        payload:
            'techtalk://prefix-youtube-landing/contents-detail/NMdnzvPsGu8');
  }
}
