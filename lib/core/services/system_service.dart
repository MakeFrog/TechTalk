///
/// 앱 시스템 정보를 관리하는 클래스.
/// 아래와 같은 기능을 관리
/// 1. 앱 버전 정보 관리
/// 2. 실시간으로 네트워크 상태를 감지하고, 네트워크 유실이 되었을 때 모당창을 노출
/// 3. 최초 로드시 필요한 동작을 조건별로 처리 (앱 점검, 버전 업데이트 권유, 공지사항 등등)
///

/// NOTE 임시 커밋

// class SystemService extends BaseService {
//   SystemService(this._systemRepository);
//
//   final SystemRepository _systemRepository;
//
//   ///
//   /// 버전 정보
//   ///
//   late final VersionEntity versionInfo;
//
//   Future<void> fetchVersionInfo() async {
//     final response = await _systemRepository.getVersionInfo();
//
//     response.fold(
//       onSuccess: (version) {
//         versionInfo = version;
//       },
//       onFailure: (e) {
//         ToastService.show(
//           NormalToast(message: '버전 정보를 불러올 수 없습니다.'),
//         );
//       },
//     );
//   }
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//   }
// }
