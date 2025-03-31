import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/features/youtube/index.dart';

class YoutubeMainEntity {
  final String id;

  final String thumbnailImgUrl;

  final String contentsTitle;

  final int qnaNum; // 아직 등록되지 않은 비디오면 0이 기본값

  final ChannelEntity channel;

  final Set<SkillEntity> relatedSkillIds;

  final Set<JobGroupEntity> relatedJobs;

  final DateTime techtalkUploadDate;

  final DateTime videoPublishDate;

  final Duration videoDuration;

  YoutubeMainEntity({
    required this.id,
    required this.thumbnailImgUrl,
    required this.contentsTitle,
    required this.channel,
    required this.relatedJobs,
    required this.relatedSkillIds,
    required this.videoDuration,
    required this.videoPublishDate,
    required this.techtalkUploadDate,
    this.qnaNum = 0,
  });

  YoutubeMainModel toModel({
    required String uploaderId,
    required String uploadLanguageCode,
  }) =>
      YoutubeMainModel(
        id: id,
        title: contentsTitle,
        thumbnailImgUrl: thumbnailImgUrl,
        videoDuration: videoDuration,
        qnaNum: qnaNum,
        relatedSkillIds: relatedSkillIds.map((skill) => skill.id).toList(),
        relatedJobGroupIds: relatedJobs.map((job) => job.id).toList(),
        channel: channel.toModel(),
        uploadAt: techtalkUploadDate,
        videoPublishedDate: videoPublishDate,
        channelRef: FirestoreYoutubeChannelRef.document(channel.id),
        uploadLanguageCode: uploadLanguageCode,
      );

  factory YoutubeMainEntity.fromUploadResponse({
    required YoutubeVideoEntity video,
    required YoutubeAiQnaAndIdsResponse qnaAndIds,
  }) {
    return YoutubeMainEntity(
      id: video.id,
      thumbnailImgUrl: video.thumbnails.highResUrl,
      contentsTitle: video.title,
      channel: video.channel,
      qnaNum: qnaAndIds.qnas.length,
      relatedJobs: qnaAndIds.jogGroups.toSet()
        ..removeWhere((e) => e == JobGroupEntity.undefinedKey),
      relatedSkillIds: qnaAndIds.skills..removeWhere((e) => e.isUndefined),
      videoDuration: video.duration ?? Duration.zero,
      videoPublishDate: video.publishedDate ?? DateTime.now(),
      techtalkUploadDate: DateTime.now(),
    );
  }

  YoutubeMainEntity copyWith({
    String? id,
    String? thumbnailImgUrl,
    String? contentsTitle,
    int? qnaNum,
    ChannelEntity? channel,
    Set<SkillEntity>? relatedSkillIds,
    Set<JobGroupEntity>? relatedJobs,
    DateTime? techtalkUploadDate,
    DateTime? videoPublishDate,
    Duration? videoDuration,
  }) {
    return YoutubeMainEntity(
      id: id ?? this.id,
      thumbnailImgUrl: thumbnailImgUrl ?? this.thumbnailImgUrl,
      contentsTitle: contentsTitle ?? this.contentsTitle,
      qnaNum: qnaNum ?? this.qnaNum,
      channel: channel ?? this.channel,
      relatedSkillIds: relatedSkillIds ?? this.relatedSkillIds,
      relatedJobs: relatedJobs ?? this.relatedJobs,
      techtalkUploadDate: techtalkUploadDate ?? this.techtalkUploadDate,
      videoPublishDate: videoPublishDate ?? this.videoPublishDate,
      videoDuration: videoDuration ?? this.videoDuration,
    );
  }
}
