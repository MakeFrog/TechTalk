import 'dart:developer';

import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/entities/topic_entity.dart';
import 'package:techtalk/features/interview/interview.dart';

///
/// '면접 주제' 리스트를 보관하는 클래스
/// [Splash] 단계에서 데이터를 초기화됨.
///

class StoredTopics {
  StoredTopics() {
    _initializeTopics();
  }

  static final List<TopicEntity> list = [];

  Future<void> _initializeTopics() async {
    final response = await getTotalTopicsUseCase.call();

    response.fold(
      onSuccess: (topics) {
        list.addAll(topics);
      },
      onFailure: (e) {
        log(e.toString());
      },
    );
  }

  static TopicEntity getById(String id) {
    return list.firstWhere(
      (topic) => topic.id == id,
      orElse: () => throw Exception('Unexpected Topic Id Value'),
    );
  }

  //// TEMP
  static TopicEntity get selectedTopic => TopicEntity(
        id: 'swift',
        name: '스위프트',
        imageUrl: 'https://developer.apple.com/swift/images/swift-og.png',
        category: InterviewTopicCategory.framework,
      );
}
