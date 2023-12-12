import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/interview_new/topic/interview_topic.dart';

part 'interview_topic_category_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class InterviewTopicCategoryModel {
  InterviewTopicCategoryModel({
    required this.id,
    required this.text,
  });

  final String id;
  final String text;

  InterviewTopicCategoryEntity toEntity() {
    return InterviewTopicCategoryEntity(
      id: id,
      text: text,
    );
  }

  factory InterviewTopicCategoryModel.fromJson(Map<String, dynamic> json) {
    return _$InterviewTopicCategoryModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InterviewTopicCategoryModelToJson(this);
}
