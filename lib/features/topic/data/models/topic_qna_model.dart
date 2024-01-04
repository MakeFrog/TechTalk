import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/topic/entities/topic_qna_entity.dart';

part 'topic_qna_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TopicQnaModel {
  TopicQnaModel({
    required this.id,
    required this.question,
    required this.answers,
  });

  final String id;
  final String question;
  final List<String> answers;

  TopicQnaEntity toEntity() {
    return TopicQnaEntity(
      id: id,
      question: question,
      answers: answers,
    );
  }

  factory TopicQnaModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      TopicQnaModel.fromJson(snapshot.data()!);

  factory TopicQnaModel.fromJson(Map<String, dynamic> json) {
    return _$TopicQnaModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TopicQnaModelToJson(this);
}
