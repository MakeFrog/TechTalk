import 'package:collection/collection.dart';
import 'package:techtalk/features/topic/topic.dart';

///
/// '면접 주제' 리스트를 보관하는 클래스
/// [Splash] 단계에서 데이터를 초기화됨.
///
class StoredTopics {
  static final List<TopicEntity> list = [];

  static Future<void> initialize() async {
    try {
      final List<TopicModel> response = await topicRemoteDataSource.getTopics();
      list.addAll(response.map((e) => e.toEntity()).toList());
    } on Exception catch (e) {
      print('아지랑이 : ${e}');
      throw '면접 주제 호출 실패';
    }
  }

  /// 특정 면접 주제 entity를 id 값을 기반으로 리턴
  static TopicEntity getById(String id) {
    return list.firstWhere(
      (topic) => topic.id == id,
      orElse: () => throw Exception('Unexpected Topic Id Value'),
    );
  }

  static TopicEntity? getBySkillId(String id) {
    return list.firstWhereOrNull((topic) => topic.skillIds.contains(id));
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
