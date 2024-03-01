import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

mixin class StudyTopicSelectionEvent {
  void onTapCard(
    WidgetRef ref, {
    required TopicEntity topic,
  }) {
    FirebaseAnalytics.instance.logEvent(
      name: 'Go to Study Detail',
      parameters: {
        'user_id': ref.read(userInfoProvider).requireValue?.uid,
        'user_name': ref.read(userInfoProvider).requireValue?.nickname,
        'topic': topic.text,
      },
    );
    StudyRoute(topic).push(rootNavigatorKey.currentContext!);
  }
}
