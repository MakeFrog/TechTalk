import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/core/utils/time_stamp_converter.dart';

part 'topic_model.freezed.dart';
part 'topic_model.g.dart';

@freezed
class TopicModel with _$TopicModel {
  const factory TopicModel({
    required String categoryId,
    required String imageUrl,
    required String id,
    required String name,
    @TimeStampConverter() required DateTime lastUpdateDate,
  }) = _TopicModel;

  factory TopicModel.fromJson(Map<String, dynamic> json) =>
      _$TopicModelFromJson(json);

  factory TopicModel.fromFirestore(
          DocumentSnapshot snapshot, SnapshotOptions? options) =>
      TopicModel.fromJson(snapshot.data() as Map<String, dynamic>);
}
