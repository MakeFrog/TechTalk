import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/topic/entities/topic_question_entity.dart';

part 'topic_question_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TopicQuestionModel {
  TopicQuestionModel({
    required this.id,
    required this.question,
    required this.answers,
  });

  final String id;
  final String question;
  final List<String> answers;

  TopicQuestionEntity toEntity() {
    return TopicQuestionEntity(
      id: id,
      question: question,
      answers: answers,
    );
  }

  factory TopicQuestionModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      TopicQuestionModel.fromJson(snapshot.data()!);

  factory TopicQuestionModel.fromJson(Map<String, dynamic> json) {
    return _$TopicQuestionModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TopicQuestionModelToJson(this);
}
