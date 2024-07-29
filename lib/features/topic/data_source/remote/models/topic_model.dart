import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/modules/converter/time_stamp_converter.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'topic_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TopicModel {
  TopicModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.enName,
    this.imagePath,
    required this.skillIds,
    required this.isAvailable,
    required this.updatedAt,
  });

  final String id;
  final String categoryId;
  final List<String> skillIds;
  final String name;
  final String enName;
  final String? imagePath;
  final bool isAvailable;
  @TimeStampConverter()
  final DateTime updatedAt;

  TopicEntity toEntity() {
    return TopicEntity(
      id: id,
      categoryId: categoryId,
      text: AppLocale.isEn ? enName : name,
      skillIds: skillIds,
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
