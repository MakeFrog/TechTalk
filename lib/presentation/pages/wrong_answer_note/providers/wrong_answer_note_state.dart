import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

mixin class WrongAnswerNoteState {
  ///
  /// 유저 정보에 기록된 면접 주제 목록
  ///
  List<TopicEntity> userTopicRecords(WidgetRef ref) =>
      ref.watch(userInfoProvider).requireValue!.targetedTopics;
}
