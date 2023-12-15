enum JobGroupModel {
  frondEndDev(id: 'frontend-developer', name: '프론트앤드 개발자'),
  backEndDev(id: 'backend-developer', name: '백앤드 개발자'),
  serverDev(id: 'server-developer', name: '서버 개발자'),
  fullStackDev(id: 'full-stack-developer', name: '풀스택 개발자'),
  androidDev(id: 'android-developer', name: '안드로이드 개발자'),
  iosDev(id: 'ios-developer', name: 'iOS 개발자'),
  crossPlatformDev(id: 'cross-platform-developer', name: '크로스플랫폼 개발자'),
  gameClientDev(id: 'game-client-developer', name: '게임 클라이언트 개발자'),
  gameServerDev(id: 'game-server-developer', name: '게임 서버 개발자');

  final String id;
  final String name;

  const JobGroupModel({
    required this.id,
    required this.name,
  });
}
