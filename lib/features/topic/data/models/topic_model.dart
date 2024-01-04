import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/core/utils/time_stamp_converter.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'topic_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TopicModel {
  TopicModel({
    required this.id,
    required this.categoryId,
    required this.name,
    this.imagePath,
    required this.isAvailable,
    required this.updatedAt,
  });

  final String id;
  final String categoryId;
  final String name;
  final String? imagePath;
  final bool isAvailable;
  @TimeStampConverter()
  final DateTime updatedAt;

  TopicEntity toEntity() {
    return TopicEntity(
      id: id,
      categoryId: categoryId,
      text: name,
      imageUrl: imagePath,
      isAvailable: isAvailable,
      updatedAt: updatedAt,
    );
  }

  factory TopicModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      TopicModel.fromJson(snapshot.data()!);

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return _$TopicModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TopicModelToJson(this);
}
