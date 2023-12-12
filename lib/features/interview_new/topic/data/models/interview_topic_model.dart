import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/interview_new/topic/data/models/interview_topic_category_model.dart';
import 'package:techtalk/features/interview_new/topic/interview_topic.dart';

part 'interview_topic_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class InterviewTopicModel {
  InterviewTopicModel({
    required this.id,
    required this.text,
    this.imageUrl,
    required this.category,
    required this.isAvailable,
  });

  final String id;
  final String text;
  final String? imageUrl;
  final InterviewTopicCategoryModel category;
  final bool isAvailable;

  InterviewTopicEntity toEntity() {
    return InterviewTopicEntity(
      id: id,
      text: text,
      category: category.toEntity(),
      isAvailable: isAvailable,
    );
  }

  factory InterviewTopicModel.fromJson(Map<String, dynamic> json) {
    return _$InterviewTopicModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InterviewTopicModelToJson(this);
}
