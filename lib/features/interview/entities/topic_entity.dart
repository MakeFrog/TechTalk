import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/data/models/topic_model.dart';

class TopicEntity {
  final String id;
  final String name;
  final String imageUrl;
  final InterviewTopicCategory category;

  TopicEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
  });

  factory TopicEntity.fromModel(TopicModel model) => TopicEntity(
        category: InterviewTopicCategory.getById(model.categoryId),
        id: model.id,
        name: model.name,
        imageUrl: model.imageUrl,
      );
}
