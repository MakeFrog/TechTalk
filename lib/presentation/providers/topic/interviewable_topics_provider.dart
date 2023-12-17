import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/providers/topic/topics_provider.dart';

part 'interviewable_topics_provider.g.dart';

@Riverpod(keepAlive: true)
List<Topic> interviewableTopics(InterviewableTopicsRef ref) {
  final topics = ref.watch(topicsProvider).requireValue;

  return [
    ...topics.where((element) => element.isAvailable),
  ];
}
