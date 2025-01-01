import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/core/modules/converter/time_stamp_converter.dart';
import 'package:techtalk/features/contents/data_source/remote/models/contents_author_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_content_overview_model.dart';
import 'package:techtalk/features/contents/data_source/remote/youtube_contents_overview_ref.dart';
import 'package:techtalk/features/contents/repositories/entities/contents_author_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/contents_overview_entity.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';

part 'youtube_video_contents_overview_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class YoutubeContentsOverviewModel {
  YoutubeContentsOverviewModel({
    required this.id,
    required this.title,
    required this.thumbnailImgUrl,
    required this.videoDuration,
    required this.qnaNum,
    this.channelRef,
    this.channel,
    required this.uploaderId,
    required this.relatedSkillIds,
    required this.relatedJobGroupIds,
    required this.uploadAt,
    required this.videoPublishedDate,
    required this.uploadLanguageCode,
  });

  final String id;

  final String thumbnailImgUrl;

  final String title;

  final Duration videoDuration;

  final int qnaNum;

  final List<String> relatedSkillIds;

  final List<String> relatedJobGroupIds;

  @TimeStampConverter()
  final DateTime videoPublishedDate;

  @TimeStampConverter()
  final DateTime uploadAt;

  /// Firestore의 DocumentReference 필드
  @JsonKey(includeFromJson: false) // JSON 직렬화에서 무시
  final DocumentReference? channelRef;

  /// 채널정보
  /// [channelRef]를 통해 참조된 데이터로 필드가 갱신됨
  final ChannelModel? channel;

  ///
  /// 업로드 될 때 적용된 언어코드
  ///
  final String uploadLanguageCode;

  ///
  /// 업로드한 유저 id
  ///
  final String uploaderId;

  /// 엔티티로 변환
  YoutubeContentOverviewEntity toEntity(List<SkillEntity> skills) {
    return YoutubeContentOverviewEntity(
      id: id,
      thumbnailImgUrl: thumbnailImgUrl,
      contentsTitle: title,
      qnaNum: qnaNum,
      channel: channel?.toEntity() ?? ChannelEntity.undefined(),
      relatedSkillIds: skills.toSet(),
      relatedJobs: relatedJobGroupIds.map(JobGroup.getById).toSet(),
      videoDuration: videoDuration,
      techtalkUploadDate: uploadAt,
      videoPublishDate: videoPublishedDate,
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

  static Map<String, Object?> toFiresTore(
    YoutubeContentsOverviewModel model,
    SetOptions? options,
  ) {
    final data = model.toJson();
    data['channel_ref'] = model.channel != null
        ? FirestoreYoutubeChannelRef.document(model.channel!.id)
        : null;
    return data;
  }

  /// JSON에서 모델로 변환
  factory YoutubeContentsOverviewModel.fromJson(Map<String, dynamic> json) =>
      _$YoutubeContentsOverviewModelFromJson(json);

  /// 모델을 JSON으로 변환
  // Map<String, dynamic> toJson() => _$YoutubeContentsOverviewModelToJson(this);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'thumbnail_img_url': thumbnailImgUrl,
      'title': title,
      'video_duration': videoDuration.inMicroseconds,
      'qna_num': qnaNum,
      'related_skill_ids': relatedSkillIds,
      'related_job_group_ids': relatedJobGroupIds,
      'video_published_date':
          const TimeStampConverter().toJson(videoPublishedDate),
      'upload_at': const TimeStampConverter().toJson(uploadAt),
      'channel_ref':
          FirestoreYoutubeChannelRef.document(channel?.id ?? 'undefined'),
    };
  }

  YoutubeContentsOverviewModel copyWith({
    String? id,
    String? thumbnailImgUrl,
    String? title,
    Duration? videoDuration,
    int? qnaNum,
    List<String>? relatedSkillIds,
    List<String>? relatedJobGroupIds,
    DateTime? videoPublishedDate,
    DateTime? uploadAt,
    DocumentReference? channelRef,
    ChannelModel? channel,
    String? uploadLanguageCode,
    String? uploaderId,
  }) {
    return YoutubeContentsOverviewModel(
      id: id ?? this.id,
      thumbnailImgUrl: thumbnailImgUrl ?? this.thumbnailImgUrl,
      title: title ?? this.title,
      videoDuration: videoDuration ?? this.videoDuration,
      qnaNum: qnaNum ?? this.qnaNum,
      relatedSkillIds: relatedSkillIds ?? this.relatedSkillIds,
      relatedJobGroupIds: relatedJobGroupIds ?? this.relatedJobGroupIds,
      videoPublishedDate: videoPublishedDate ?? this.videoPublishedDate,
      uploadAt: uploadAt ?? this.uploadAt,
      channelRef: channelRef ?? this.channelRef,
      channel: channel ?? this.channel,
      uploadLanguageCode: uploadLanguageCode ?? this.uploadLanguageCode,
      uploaderId: uploaderId ?? this.uploaderId,
    );
  }
}
