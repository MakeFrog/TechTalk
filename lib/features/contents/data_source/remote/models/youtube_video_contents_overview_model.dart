import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/core/modules/converter/time_stamp_converter.dart';
import 'package:techtalk/features/contents/data_source/remote/models/contents_author_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_content_overview_model.dart';
import 'package:techtalk/features/contents/repositories/entities/contents_author_entity.dart';
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
    this.channelRef,
    this.channel,
    required this.relatedSkillIds,
    required this.relatedJobGroupIds,
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

  @TimeStampConverter()
  final DateTime createdAt;

  @TimeStampConverter()
  final DateTime uploadAt;

  /// Firestore의 DocumentReference 필드
  @JsonKey(includeFromJson: false) // JSON 직렬화에서 무시
  final DocumentReference? channelRef;

  /// 채널정보
  /// [channelRef]를 통해 참조된 데이터로 필드가 갱신됨
  final ChannelModel? channel;

  /// 엔티티로 변환
  YoutubeContentOverviewEntity toEntity() {
    return YoutubeContentOverviewEntity(
      id: id,
      thumbnailImgUrl: thumbnailImgUrl,
      contentsTitle: contentsTitle,
      qnaNum: qnaNum,
      channel: channel?.toEntity() ?? ChannelEntity.undefined(),
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
  ) {
    final channelRef =
        snapshot.data()!['channel_ref'] as DocumentReference?; // 수동으로 처리
    return YoutubeContentsOverviewModel.fromJson(snapshot.data()!)
        .copyWith(channelRef: channelRef);
  }

  /// JSON에서 모델로 변환
  factory YoutubeContentsOverviewModel.fromJson(Map<String, dynamic> json) =>
      _$YoutubeContentsOverviewModelFromJson(json);

  /// 모델을 JSON으로 변환
  Map<String, dynamic> toJson() => _$YoutubeContentsOverviewModelToJson(this);

  YoutubeContentsOverviewModel copyWith({
    String? id,
    String? thumbnailImgUrl,
    String? contentsTitle,
    Duration? videoDuration,
    int? qnaNum,
    List<String>? relatedSkillIds,
    List<String>? relatedJobGroupIds,
    ChannelModel? channel,
    DateTime? createdAt,
    DateTime? uploadAt,
    DocumentReference? channelRef,
  }) {
    return YoutubeContentsOverviewModel(
      id: id ?? this.id,
      thumbnailImgUrl: thumbnailImgUrl ?? this.thumbnailImgUrl,
      contentsTitle: contentsTitle ?? this.contentsTitle,
      videoDuration: videoDuration ?? this.videoDuration,
      qnaNum: qnaNum ?? this.qnaNum,
      relatedSkillIds: relatedSkillIds ?? this.relatedSkillIds,
      relatedJobGroupIds: relatedJobGroupIds ?? this.relatedJobGroupIds,
      channel: channel ?? this.channel,
      createdAt: createdAt ?? this.createdAt,
      uploadAt: uploadAt ?? this.uploadAt,
      channelRef: channelRef ?? this.channelRef,
    );
  }
}
