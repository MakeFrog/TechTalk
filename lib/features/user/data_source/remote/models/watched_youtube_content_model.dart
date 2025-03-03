import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/core/modules/converter/time_stamp_converter.dart';

part 'watched_youtube_content_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class WatchedYoutubeModel {
  const WatchedYoutubeModel({required this.id, required this.watchedAt});

  final String id;

  /// 마지막 로그인 시간
  @TimeStampConverter()
  final DateTime watchedAt;

  factory WatchedYoutubeModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return WatchedYoutubeModel.fromJson(snapshot.data()!);
  }

  factory WatchedYoutubeModel.fromJson(Map<String, dynamic> json) {
    return _$WatchedYoutubeModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WatchedYoutubeModelToJson(this);

// Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
