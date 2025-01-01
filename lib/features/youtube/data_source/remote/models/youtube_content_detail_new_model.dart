import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/youtube/index.dart';

part 'youtube_content_detail_new_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class YoutubeContentsDetailNewModel {
  YoutubeContentsDetailNewModel({
    required this.summary,
  });

  final SummaryModel summary;

  factory YoutubeContentsDetailNewModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      YoutubeContentsDetailNewModel.fromJson(snapshot.data()!);

  factory YoutubeContentsDetailNewModel.fromJson(Map<String, dynamic> json) {
    return _$YoutubeContentsDetailNewModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$YoutubeContentsDetailNewModelToJson(this);
}
