import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/core/utils/time_stamp_converter.dart';
import 'package:techtalk/features/topic/entities/topic.enum.dart';

part 'topic_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
  converters: [
    TimeStampConverter(),
  ],
)
class TopicModel {
  TopicModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.isAvailable,
    this.updatedAt,
  });

  final String id;
  final String name;
  final String categoryId;
  final bool isAvailable;
  final DateTime? updatedAt;

  factory TopicModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      TopicModel.fromJson(snapshot.data()!);

  factory TopicModel.fromEntity(Topic data) {
    return TopicModel(
      id: data.id,
      name: data.text,
      categoryId: data.category.id,
      isAvailable: data.isAvailable,
    );
  }

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return _$TopicModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TopicModelToJson(this);
}
