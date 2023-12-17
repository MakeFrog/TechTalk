import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/data/models/topic_model.dart';

class TopicEntity {
  final String id; // ID
  final String name; // 면접 주제 이름
  final String imageUrl; // 면접 주제 이미지
  final TopicCategory category; // 면접 주제 카테고리
  final DateTime lastUpdatedDate; // 마지막으로 업데이트된 날짜

  TopicEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.lastUpdatedDate,
  });

  factory TopicEntity.fromModel(TopicModel model) => TopicEntity(
        category: TopicCategory.getById(model.categoryId),
        id: model.id,
        name: model.name,
        imageUrl: model.imageUrl,
        lastUpdatedDate: model.lastUpdatedDate,
      );
}
