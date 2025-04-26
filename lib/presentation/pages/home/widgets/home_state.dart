import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/pages/main/provider/show_new_feature_indicator_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';
import 'package:techtalk/presentation/providers/user/user_topics_provider.dart';

mixin class HomeState {
  ///
  /// 등록된 스킬과 연관된 면접 주제+ 면접 기록이 있는 면접 주제
  ///
  List<TopicEntity> targetedTopics(WidgetRef ref) =>
      ref.watch(userTopicsProvider);

  ///
  /// 유저 엔티티 정보
  ///
  AsyncValue<UserEntity?> userAsync(WidgetRef ref) =>
      ref.watch(userInfoProvider);

  ///
  /// 유저 엔티티 정보
  ///
  UserEntity? user(WidgetRef ref) => ref.watch(userInfoProvider).requireValue;

  ///
  /// 유튜브 신기능 말풍선 노출 여부
  ///
  bool showNewFeatureIndicator(WidgetRef ref) {
    return ref.watch(showNewFeatureIndicatorProvider);
  }
}
