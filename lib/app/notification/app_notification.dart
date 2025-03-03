import 'package:firebase_messaging/firebase_messaging.dart';

abstract class AppNotification {
  Future<void> init() async {
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        if (message.notification != null) {}
      }
    });
  }
}
