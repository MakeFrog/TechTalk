import 'dart:async';

import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';

final class ProficiencyInterviewTopicSelectionRouteArgument {
  final Completer<List<TopicEntity>?> routeResCompleter;

  const ProficiencyInterviewTopicSelectionRouteArgument(this.routeResCompleter);
}
