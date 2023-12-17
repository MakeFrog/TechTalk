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

  /// 특정 면접 주제 entity를 id 값을 기반으로 리턴
  static TopicEntity getById(String id) {
    return list.firstWhere(
      (topic) => topic.id == id,
      orElse: () => throw Exception('Unexpected Topic Id Value'),
    );
  }

  /// 특정 면접 주제의 마지막 업데이트된 날짜를 id 값을 기반으로 리턴
  static DateTime getLastUpdatedDateById(String id) {
    final selectedTopic = list.firstWhere(
      (topic) => topic.id == id,
      orElse: () => throw Exception('Unexpected Topic Id Value'),
    );

    return selectedTopic.lastUpdatedDate;
  }

  //// TEMP
  static TopicEntity get selectedTopic => TopicEntity(
        id: 'swift',
        name: '스위프트',
        imageUrl: 'https://developer.apple.com/swift/images/swift-og.png',
        category: TopicCategory.framework,
        lastUpdatedDate: DateTime.timestamp(),
      );
}
