import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/youtube/index.dart';

part 'youtube_detail_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class YoutubeDetailModel {
  YoutubeDetailModel({
    required this.summary,
  });

  final SummaryModel summary;

  factory YoutubeDetailModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      YoutubeDetailModel.fromJson(snapshot.data()!);

  factory YoutubeDetailModel.fromJson(Map<String, dynamic> json) {
    return _$YoutubeDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$YoutubeDetailModelToJson(this);
}
