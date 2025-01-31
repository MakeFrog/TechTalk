import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/core/modules/converter/time_stamp_converter.dart';
part 'uploaded_youtube_content_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class UploadedYoutubeModel {
  const UploadedYoutubeModel({required this.id, required this.uploadAt});

  final String id;

  /// 마지막 로그인 시간
  @TimeStampConverter()
  final DateTime uploadAt;

  factory UploadedYoutubeModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return UploadedYoutubeModel.fromJson(snapshot.data()!);
  }

  factory UploadedYoutubeModel.fromJson(Map<String, dynamic> json) {
    return _$UploadedYoutubeModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UploadedYoutubeModelToJson(this);

// Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
