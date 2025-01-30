import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/util/app_logger.dart';
import 'package:techtalk/core/helper/bool_extension.dart';
import 'package:techtalk/features/user/user.dart';

part 'show_new_feature_indicator_provider.g.dart';

///
/// [_BottomNavigationBar]에 노출되는
/// 신기능 말품성 인디케이터 노출 여부
///
@riverpod
class ShowNewFeatureIndicator extends _$ShowNewFeatureIndicator {
  // ignore: avoid_public_notifier_properties
  bool initialValue = false;

  @override
  bool build() {
    final response = userRepository.hasSeenNewYoutubeFeature();
    return response.fold(
      onSuccess: (hasSeen) {
        initialValue = !hasSeen;
        return !hasSeen;
      },
      onFailure: (e) {
        logger.e(e);
        return false;
      },
    );
  }

  Future<void> disable() async {
    if (state.isTrue) {
      state = false;
    }

    final response = await userRepository.disableNewFeatureShowState();
    response.fold(
      onSuccess: (_) {
        logger.i('LOCAL > 신기능 말풍선 인디케이터 노출 해제');
      },
      onFailure: (e) {
        logger.e(e);
      },
    );
  }
}
