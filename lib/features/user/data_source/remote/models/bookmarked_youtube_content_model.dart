import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/core/modules/converter/time_stamp_converter.dart';

part 'bookmarked_youtube_content_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class BookmarkedYoutubeModel {
  const BookmarkedYoutubeModel({required this.id, required this.bookmarkedAt});

  final String id;

  /// 마지막 로그인 시간
  @TimeStampConverter()
  final DateTime bookmarkedAt;

  factory BookmarkedYoutubeModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return BookmarkedYoutubeModel.fromJson(snapshot.data()!);
  }

  factory BookmarkedYoutubeModel.fromJson(Map<String, dynamic> json) {
    return _$BookmarkedYoutubeModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BookmarkedYoutubeModelToJson(this);

// Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
