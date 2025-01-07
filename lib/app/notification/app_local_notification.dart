import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class AppLocalNotification {
  late final FlutterLocalNotificationsPlugin _local;

  Future<void> _initialization() async {
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
    await _local.initialize(settings);
  }
}
