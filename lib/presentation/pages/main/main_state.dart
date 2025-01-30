import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/main/provider/show_new_feature_indicator_provider.dart';

mixin class MainState {
  ///
  /// 유튜브 신기능 말풍선 노출 여부
  ///
  bool showNewFeatureIndicator(WidgetRef ref) {
    return ref.watch(showNewFeatureIndicatorProvider);
  }
}
