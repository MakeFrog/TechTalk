import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/features/interview/data/models/interview_topic_model.dart';

part 'interview_topic_entity.freezed.dart';
part 'interview_topic_entity.g.dart';

@freezed
class InterviewTopicEntity with _$InterviewTopicEntity {
  const factory InterviewTopicEntity({
    required String name,
    String? imageUrl,
  }) = _InterviewTopicEntity;

  factory InterviewTopicEntity.fromModel(InterviewTopicModel model) =>
      InterviewTopicEntity(
        name: model.name,
        imageUrl: model.topicImageUrl,
      );

  factory InterviewTopicEntity.fromJson(Map<String, dynamic> json) =>
      _$InterviewTopicEntityFromJson(json);
}
