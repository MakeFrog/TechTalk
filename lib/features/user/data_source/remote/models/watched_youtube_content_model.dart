import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/core/modules/converter/time_stamp_converter.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_main_model.dart';

part 'watched_youtube_content_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class WatchedYoutubeContent {
  const WatchedYoutubeContent({required this.info, required this.watchedAt});

  final YoutubeMainModel info;

  /// 마지막 로그인 시간
  @TimeStampConverter()
  final DateTime watchedAt;

  factory WatchedYoutubeContent.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final watchedAt = snapshot.get('watched_at');
    return WatchedYoutubeContent.fromJson(snapshot.data()!);
  }

  factory WatchedYoutubeContent.fromJson(Map<String, dynamic> json) {
    return _$WatchedYoutubeContentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WatchedYoutubeContentToJson(this);

// Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
