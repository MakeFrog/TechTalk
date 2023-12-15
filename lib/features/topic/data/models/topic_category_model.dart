import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/topic/entities/topic_category.enum.dart';

part 'topic_category_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TopicCategoryModel {
  TopicCategoryModel({
    required this.id,
    required this.text,
  });

  final String id;
  final String text;

  factory TopicCategoryModel.fromEntity(
    TopicCategory data,
  ) {
    return TopicCategoryModel(
      id: data.id,
      text: data.text,
    );
  }

  factory TopicCategoryModel.fromJson(Map<String, dynamic> json) {
    return _$TopicCategoryModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TopicCategoryModelToJson(this);
}
