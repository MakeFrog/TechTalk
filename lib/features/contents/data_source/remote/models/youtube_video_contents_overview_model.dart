import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/core/modules/converter/time_stamp_converter.dart';
import 'package:techtalk/features/contents/data_source/remote/models/contents_author_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_content_overview_model.dart';
import 'package:techtalk/features/contents/repositories/entities/contents_overview_entity.dart';

part 'youtube_video_contents_overview_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class YoutubeContentsOverviewModel {
  YoutubeContentsOverviewModel({
    required this.id,
    required this.contentsTitle,
    required this.thumbnailImgUrl,
    required this.videoDuration,
    required this.qnaNum,
    required this.relatedSkillIds,
    required this.relatedJobGroupIds,
    required this.channel,
    required this.uploadAt,
    required this.createdAt,
  });

  final String id;

  final String thumbnailImgUrl;

  final String contentsTitle;

  final Duration videoDuration;

  final int qnaNum;

  final List<String> relatedSkillIds;

  final List<String> relatedJobGroupIds;

  /// TODO : XIMYA
  /// 추후 필드명 변경
  @JsonKey(name: 'author')
  final ChannelModel channel;

  @TimeStampConverter()
  final DateTime createdAt;

  @TimeStampConverter()
  final DateTime uploadAt;

  /// 엔티티로 변환
  YoutubeContentOverviewEntity toEntity() {
    return YoutubeContentOverviewEntity(
      id: id,
      thumbnailImgUrl: thumbnailImgUrl,
      contentsTitle: contentsTitle,
      qnaNum: qnaNum,
      channel: channel.toEntity(),
      relatedSkillIds: relatedSkillIds.toSet(),
      relatedJobs: relatedJobGroupIds.map(JobGroup.getById).toSet(),
      videoDuration: videoDuration,
      uploadAt: uploadAt,
      createdAt: createdAt,
    );
  }

  /// Firestore에서 가져온 DocumentSnapshot을 모델로 변환
  factory YoutubeContentsOverviewModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      YoutubeContentsOverviewModel.fromJson(snapshot.data()!);

  /// JSON에서 모델로 변환
  factory YoutubeContentsOverviewModel.fromJson(Map<String, dynamic> json) =>
      _$YoutubeContentsOverviewModelFromJson(json);

  /// 모델을 JSON으로 변환
  Map<String, dynamic> toJson() => _$YoutubeContentsOverviewModelToJson(this);
}
