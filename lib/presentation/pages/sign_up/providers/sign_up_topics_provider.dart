import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'sign_up_topics_provider.g.dart';

@riverpod
class SignUpTopics extends _$SignUpTopics {
  @override
  List<TopicEntity> build() => [];

  void add(TopicEntity item) {
    state = state.toList()..add(item);
  }

  void remove(TopicEntity item) {
    state = state.toList()..remove(item);
  }

  void removeAt(int index) {
    state = state.toList()..removeAt(index);
  }
}
