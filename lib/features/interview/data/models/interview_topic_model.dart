import 'package:freezed_annotation/freezed_annotation.dart';

part 'interview_topic_model.freezed.dart';
part 'interview_topic_model.g.dart';

@freezed
class InterviewTopicModel with _$InterviewTopicModel {
  const factory InterviewTopicModel({
    required String name,
    String? topicImageUrl,
  }) = _InterviewTopicModel;

  factory InterviewTopicModel.fromJson(Map<String, dynamic> json) =>
      _$InterviewTopicModelFromJson(json);
}
