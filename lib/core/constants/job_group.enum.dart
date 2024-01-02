///
/// 개발 직군 리스트.
/// 원티드 채용 사이트를 참고함.
///

enum JobGroup {
  SOFTWARE_ENGINEER('software-engineer', '소프트웨어 엔지니어'),
  WEB_DEVELOPER('web-developer', '웹 개발자'),
  SERVER_DEVELOPER('server-developer', '서버 개발자'),
  FRONTEND_DEVELOPER('frontend-developer', '프론트엔드 개발자'),
  JAVA_DEVELOPER('java-developer', '자바 개발자'),
  C_CPP_DEVELOPER('c-cplusplus-developer', 'C,C++ 개발자'),
  PYTHON_DEVELOPER('python-developer', '파이썬 개발자'),
  MACHINE_LEARNING_ENGINEER('machine-learning-engineer', '머신러닝 엔지니어'),
  SYSTEM_NETWORK_ADMINISTRATOR('system-network-administrator', '시스템,네트워크 관리자'),
  ANDROID_DEVELOPER('android-developer', '안드로이드 개발자'),
  DATA_ENGINEER('data-engineer', '데이터 엔지니어'),
  DEVOPS_SYSTEM_ADMINISTRATOR(
      'devops-system-administrator', 'DevOps / 시스템 관리자'),
  NODEJS_DEVELOPER('nodejs-developer', 'Node.js 개발자'),
  IOS_DEVELOPER('ios-developer', 'iOS 개발자'),
  EMBEDDED_DEVELOPER('embedded-developer', '임베디드 개발자'),
  TECHNICAL_SUPPORT('technical-support', '기술지원'),
  DEVELOPMENT_MANAGER('development-manager', '개발 매니저'),
  DATA_SCIENTIST('data-scientist', '데이터 사이언티스트'),
  QA_TEST_ENGINEER('qa-test-engineer', 'QA,테스트 엔지니어'),
  HARDWARE_ENGINEER('hardware-engineer', '하드웨어 엔지니어'),
  BIG_DATA_ENGINEER('big-data-engineer', '빅데이터 엔지니어'),
  SECURITY_ENGINEER('security-engineer', '보안 엔지니어'),
  PRODUCT_MANAGER('product-manager', '프로덕트 매니저'),
  CROSS_PLATFORM_APP_DEVELOPER('cross-platform-app-developer', '크로스플랫폼 앱 개발자'),
  BLOCKCHAIN_PLATFORM_ENGINEER('blockchain-platform-engineer', '블록체인 플랫폼 엔지니어'),
  DBA('dba', 'DBA'),
  DOTNET_DEVELOPER('dotnet-developer', '.NET 개발자'),
  PHP_DEVELOPER('php-developer', 'PHP 개발자'),
  AUDIO_VIDEO_ENGINEER('audio-video-engineer', '영상,음성 엔지니어'),
  WEB_PUBLISHER('web-publisher', '웹 퍼블리셔'),
  ERP_SPECIALIST('erp-specialist', 'ERP전문가'),
  GRAPHICS_ENGINEER('graphics-engineer', '그래픽스 엔지니어'),
  VR_ENGINEER('vr-engineer', 'VR 엔지니어'),
  BI_ENGINEER('bi-engineer', 'BI 엔지니어'),
  RUBY_ON_RAILS_DEVELOPER('ruby-on-rails-developer', '루비온레일즈 개발자');

  final String id;
  final String name;

  const JobGroup(this.id, this.name);

  static JobGroup getById(String id) => values.firstWhere(
        (job) => job.id == id,
        orElse: () => throw Exception('InCorrect Id: $id'),
      );
}
