import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/topic/repositories/entities/topic_category_entity.dart';

part 'topic_category_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TopicCategoryModel {
  TopicCategoryModel({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory TopicCategoryModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      TopicCategoryModel.fromJson(snapshot.data()!);

  TopicCategoryEntity toEntity() {
    return TopicCategoryEntity(
      id: id,
      text: name,
    );
  }

  factory TopicCategoryModel.fromJson(Map<String, dynamic> json) {
    return _$TopicCategoryModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TopicCategoryModelToJson(this);
}
