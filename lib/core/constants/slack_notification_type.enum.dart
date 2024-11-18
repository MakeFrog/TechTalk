///
/// Slack Notification 타입
///
enum SlackNotificationType {
  signUp(':rocket:'),
  logOut(':hanKey:'),
  login(':door:'),
  event(':fire:'),
  withdraw(':cry:');

  final String icon;

  const SlackNotificationType(this.icon);
}
