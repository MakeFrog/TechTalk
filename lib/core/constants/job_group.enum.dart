import 'package:flutter/material.dart';

///
/// 개발 직군 리스트.
/// 원티드 채용 사이트를 참고함.
///

enum JobGroup {
  SOFTWARE_ENGINEER('software-engineer', '소프트웨어 엔지니어', 'Software Engineer'),
  WEB_DEVELOPER('web-developer', '웹 개발자', 'Web Developer'),
  SERVER_DEVELOPER('server-developer', '서버 개발자', 'Server Developer'),
  FRONTEND_DEVELOPER('frontend-developer', '프론트엔드 개발자', 'Frontend Developer'),
  JAVA_DEVELOPER('java-developer', '자바 개발자', 'Java Developer'),
  C_CPP_DEVELOPER('c-cplusplus-developer', 'C,C++ 개발자', 'C/C++ Developer'),
  PYTHON_DEVELOPER('python-developer', '파이썬 개발자', 'Python Developer'),
  MACHINE_LEARNING_ENGINEER(
      'machine-learning-engineer', '머신러닝 엔지니어', 'Machine Learning Engineer'),
  SYSTEM_NETWORK_ADMINISTRATOR('system-network-administrator', '시스템,네트워크 관리자',
      'System/Network Administrator'),
  ANDROID_DEVELOPER('android-developer', '안드로이드 개발자', 'Android Developer'),
  DATA_ENGINEER('data-engineer', '데이터 엔지니어', 'Data Engineer'),
  DEVOPS_SYSTEM_ADMINISTRATOR('devops-system-administrator', 'DevOps / 시스템 관리자',
      'DevOps/System Administrator'),
  NODEJS_DEVELOPER('nodejs-developer', 'Node.js 개발자', 'Node.js Developer'),
  IOS_DEVELOPER('ios-developer', 'iOS 개발자', 'iOS Developer'),
  EMBEDDED_DEVELOPER('embedded-developer', '임베디드 개발자', 'Embedded Developer'),
  TECHNICAL_SUPPORT('technical-support', '기술지원', 'Technical Support'),
  DEVELOPMENT_MANAGER('development-manager', '개발 매니저', 'Development Manager'),
  DATA_SCIENTIST('data-scientist', '데이터 사이언티스트', 'Data Scientist'),
  QA_TEST_ENGINEER('qa-test-engineer', 'QA,테스트 엔지니어', 'QA/Test Engineer'),
  HARDWARE_ENGINEER('hardware-engineer', '하드웨어 엔지니어', 'Hardware Engineer'),
  BIG_DATA_ENGINEER('big-data-engineer', '빅데이터 엔지니어', 'Big Data Engineer'),
  SECURITY_ENGINEER('security-engineer', '보안 엔지니어', 'Security Engineer'),
  PRODUCT_MANAGER('product-manager', '프로덕트 매니저', 'Product Manager'),
  CROSS_PLATFORM_APP_DEVELOPER('cross-platform-app-developer', '크로스플랫폼 앱 개발자',
      'Cross-Platform App Developer'),
  BLOCKCHAIN_PLATFORM_ENGINEER('blockchain-platform-engineer', '블록체인 플랫폼 엔지니어',
      'Blockchain Platform Engineer'),
  DBA('dba', 'DBA', 'Database Administrator'),
  DOTNET_DEVELOPER('dotnet-developer', '.NET 개발자', '.NET Developer'),
  PHP_DEVELOPER('php-developer', 'PHP 개발자', 'PHP Developer'),
  AUDIO_VIDEO_ENGINEER(
      'audio-video-engineer', '영상,음성 엔지니어', 'Audio/Video Engineer'),
  WEB_PUBLISHER('web-publisher', '웹 퍼블리셔', 'Web Publisher'),
  ERP_SPECIALIST('erp-specialist', 'ERP전문가', 'ERP Specialist'),
  GRAPHICS_ENGINEER('graphics-engineer', '그래픽스 엔지니어', 'Graphics Engineer'),
  VR_ENGINEER('vr-engineer', 'VR 엔지니어', 'VR Engineer'),
  BI_ENGINEER('bi-engineer', 'BI 엔지니어', 'BI Engineer'),
  RUBY_ON_RAILS_DEVELOPER(
      'ruby-on-rails-developer', '루비온레일즈 개발자', 'Ruby on Rails Developer');

  final String id;
  final String name;
  final String enName;

  const JobGroup(this.id, this.name, this.enName);

  static JobGroup getById(String id) =>
      values.firstWhere(
            (job) => job.id == id,
        orElse: () => throw Exception('Incorrect Id: $id'),
      );


}

class TestWidget {
  final GlobalKey<AnimatedListState> animatedlistKey;
  final JobGroup job;

  TestWidget(this.animatedlistKey, this.job);
}
