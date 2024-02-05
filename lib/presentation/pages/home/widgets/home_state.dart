import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/topic/entities/topic_entity.dart';
import 'package:techtalk/features/user/entities/user_entity.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

mixin class HomeState {
  /// 등록된 스킬과 연관된 면접 주제+ 면접 기록이 있는 면접 주제
  List<TopicEntity> targetedTopics(WidgetRef ref) =>
      ref.watch(userInfoProvider).requireValue!.targetedTopics;

  /// 홈 페이지에서 사용되는 비동기 값, 유저 엔티티 정보
  AsyncValue<UserEntity?> asyncValue(WidgetRef ref) =>
      ref.watch(userInfoProvider);
}
