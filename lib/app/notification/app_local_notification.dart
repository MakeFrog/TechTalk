import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:techtalk/app/router/deeplink/deep_link_define.enum.dart';
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
    // DarwinInitializationSettings ios = const DarwinInitializationSettings(
    //
    // );

    final DarwinInitializationSettings ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
      requestBadgePermission: true,
      notificationCategories: [
        DarwinNotificationCategory(
          'demoCategory',
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.plain('id_1', 'Action 1'),
            DarwinNotificationAction.plain('id_2', 'Action 2', options: {
              DarwinNotificationActionOption.destructive,
            }),
            DarwinNotificationAction.plain('id_3', 'Action 3', options: {
              DarwinNotificationActionOption.foreground,
            }),
          ],
          options: {DarwinNotificationCategoryOption.hiddenPreviewShowTitle},
        ),
      ],
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
  @pragma('vm:entry-point')
  static void notificationTapped(NotificationResponse response) {
    DeepLinkHandler().handleDeepLink(response.payload ?? '');
  }

  Future<void> triggerPush({
    required String title,
    required String description,
    required DeeplinkHost host,
    required String? path,
  }) async {
    NotificationDetails details = const NotificationDetails(
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
      android: AndroidNotificationDetails(
        'noChannel',
        "localPush",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await _local.show(Random().nextInt(100), title, description, details,
        payload:
            '${DeeplinkScheme.techtalk.name}://${host.toDashedString()}/$path');
  }

  Future<void> testShow() async {}
}
