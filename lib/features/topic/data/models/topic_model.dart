import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/topic/data/models/topic_category_model.dart';
import 'package:techtalk/features/topic/entities/topic.enum.dart';

part 'topic_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TopicModel {
  TopicModel({
    required this.id,
    required this.text,
    required this.category,
    this.imageUrl,
    required this.isAvailable,
  });

  final String id;
  final String text;
  final TopicCategoryModel category;
  final String? imageUrl;
  final bool isAvailable;

  factory TopicModel.fromEntity(Topic data) {
    return TopicModel(
      id: data.id,
      text: data.text,
      category: TopicCategoryModel.fromEntity(data.category),
      imageUrl: data.imageUrl,
      isAvailable: data.isAvailable,
    );
  }

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return _$TopicModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TopicModelToJson(this);
}
