import 'package:go_router/go_router.dart';

///
/// Gorouter extension 메소드
///
extension GoRouterExtension on GoRouter {
  // 특정 경로까지 뒤로 이동
  void popUntilPath(String targetPath) {
    while (routerDelegate.currentConfiguration.matches.last.matchedLocation !=
        targetPath) {
      if (!canPop()) {
        return;
      }
      pop();
    }
  }

  // 여러 경로 중 하나에 도달할 때까지 뒤로 이동
  void popUntilMultiPath(List<String> targetPaths) {
    print(
        '이지빵 : ${routerDelegate.currentConfiguration.matches.last.matchedLocation}');
    while (!targetPaths.contains(
        routerDelegate.currentConfiguration.matches.last.matchedLocation)) {
      if (!canPop()) {
        return;
      }
      pop();
    }
  }
}
