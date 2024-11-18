part of 'home_event.dart';


extension InternalHomeEvent on HomeEvent {
  ///
  /// 알람 활성화 요청
  ///
  Future<void> requestNotificationPermission(WidgetRef ref) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission();

    await ref.read(notificationStatusProvider.future);

    log('유저 알람 퍼미션 상태 :  ${settings.authorizationStatus}');
  }
}
