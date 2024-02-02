import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:techtalk/features/topic/topic.dart';

///
/// '면접 주제' 리스트를 보관하는 클래스
/// [Splash] 단계에서 데이터를 초기화됨.
///
class StoredTopics {
  static final List<TopicEntity> list = [];

  static Future<void> initializeTopics() async {
    final response = getTopicsUseCase.call();

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

  static TopicEntity? getByIdOrNull(String? id) {
    if (id == null) return null;

    return list.firstWhereOrNull(
      (topic) => topic.id == id,
    );
  }

  static bool contains(String id) {
    return list.firstWhereOrNull((e) => e.id == id) != null ? true : false;
  }
}
