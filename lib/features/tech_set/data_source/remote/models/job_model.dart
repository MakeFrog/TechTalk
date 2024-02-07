///
/// 개발 직군 리스트.
/// 원티드 채용 사이트를 참고함.
///

enum Job {
  softwareEngineer('software-engineer', '소프트웨어 엔지니어'),
  webDeveloper('web-developer', '웹 개발자'),
  serverDeveloper('server-developer', '서버 개발자'),
  frontendDeveloper('frontend-developer', '프론트엔드 개발자'),
  javaDeveloper('java-developer', '자바 개발자'),
  cCppDeveloper('c-cplusplus-developer', 'C,C++ 개발자'),
  pythonDeveloper('python-developer', '파이썬 개발자'),
  machineLearningEngineer('machine-learning-engineer', '머신러닝 엔지니어'),
  systemNetworkAdministrator('system-network-administrator', '시스템,네트워크 관리자'),
  androidDeveloper('android-developer', '안드로이드 개발자'),
  dataEngineer('data-engineer', '데이터 엔지니어'),
  devopsSystemAdministrator('devops-system-administrator', 'DevOps / 시스템 관리자'),
  nodejsDeveloper('nodejs-developer', 'Node.js 개발자'),
  iosDeveloper('ios-developer', 'iOS 개발자'),
  embeddedDeveloper('embedded-developer', '임베디드 개발자'),
  technicalSupport('technical-support', '기술지원'),
  developmentManager('development-manager', '개발 매니저'),
  dataScientist('data-scientist', '데이터 사이언티스트'),
  qaTestEngineer('qa-test-engineer', 'QA,테스트 엔지니어'),
  hardwareEngineer('hardware-engineer', '하드웨어 엔지니어'),
  bigDataEngineer('big-data-engineer', '빅데이터 엔지니어'),
  securityEngineer('security-engineer', '보안 엔지니어'),
  productManager('product-manager', '프로덕트 매니저'),
  crossPlatformAppDeveloper('cross-platform-app-developer', '크로스플랫폼 앱 개발자'),
  blockchainPlatformEngineer('blockchain-platform-engineer', '블록체인 플랫폼 엔지니어'),
  dba('dba', 'DBA'),
  dotnetDeveloper('dotnet-developer', '.NET 개발자'),
  phpDeveloper('php-developer', 'PHP 개발자'),
  audioVideoEngineer('audio-video-engineer', '영상,음성 엔지니어'),
  webPublisher('web-publisher', '웹 퍼블리셔'),
  erpSpecialist('erp-specialist', 'ERP전문가'),
  graphicsEngineer('graphics-engineer', '그래픽스 엔지니어'),
  vrEngineer('vr-engineer', 'VR 엔지니어'),
  biEngineer('bi-engineer', 'BI 엔지니어'),
  rubyOnRailsDeveloper('ruby-on-rails-developer', '루비온레일즈 개발자');

  final String id;
  final String name;

  const Job(this.id, this.name);

  static Job getById(String id) => values.firstWhere(
        (job) => job.id == id,
        orElse: () => throw Exception('InCorrect Id: $id'),
      );
}
