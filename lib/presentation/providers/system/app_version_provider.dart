import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/features/system/system.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

part 'app_version_provider.g.dart';

///
/// 앱의 버전 정보를 관리하는 provider
///
@Riverpod(keepAlive: true)
class AppVersion extends _$AppVersion {
  @override
  FutureOr<VersionEntity> build() async {
    final response = await getVersionInfoUseCase.call();

    return response.fold(
      onSuccess: (versionInfo) {
        return versionInfo;
      },
      onFailure: (e) {
        ToastService.show(NormalToast(message: '앱의 버전 정보를 가져오는데 실패하였습니다.'));
        throw e;
      },
    );
  }
}
