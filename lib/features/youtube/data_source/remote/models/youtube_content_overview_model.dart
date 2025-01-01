import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';
import 'package:techtalk/features/youtube/index.dart';

class YoutubeContentOverviewEntity {
  final String id;

  final String thumbnailImgUrl;

  final String contentsTitle;

  final int qnaNum; // 아직 등록되지 않은 비디오면 0이 기본값

  final ChannelEntity channel;

  final Set<SkillEntity> relatedSkillIds;

  final Set<JobGroup> relatedJobs;

  final DateTime techtalkUploadDate;

  final DateTime videoPublishDate;

  final Duration videoDuration;

  YoutubeContentOverviewEntity({
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

  factory YoutubeContentOverviewEntity.fromUploadResponse({
    required YoutubeVideoEntity video,
    required YoutubeAiQnaAndIdsResponse qnaAndIds,
  }) {
    return YoutubeContentOverviewEntity(
      id: video.id,
      thumbnailImgUrl: video.thumbnails.highResUrl,
      contentsTitle: video.title,
      channel: video.channel,
      qnaNum: qnaAndIds.qnas.length,
      relatedJobs: qnaAndIds.jogGroups.toSet()
        ..removeWhere((e) => e.isUndefined),
      relatedSkillIds: qnaAndIds.skills..removeWhere((e) => e.isUndefined),
      videoDuration: video.duration ?? Duration.zero,
      videoPublishDate: video.publishedDate ?? DateTime.now(),
      techtalkUploadDate: DateTime.now(),
    );
  }
}
