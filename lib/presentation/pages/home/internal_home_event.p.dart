part of 'home_event.dart';


extension InternalHomeEvent on HomeEvent {
  ///
  /// 알람 활성화 요청
  ///
  Future<void> requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission();

    log('유저 알람 퍼미션 상태 :  ${settings.authorizationStatus}');

    String? _fcmToken = await FirebaseMessaging.instance.getToken();
    log('FCM 토큰 : $_fcmToken');
  }
}
