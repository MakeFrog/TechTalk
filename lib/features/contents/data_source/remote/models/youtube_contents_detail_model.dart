import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/contents/data_source/remote/models/summary_model.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_contents_detail_entity.dart';
import 'package:techtalk/features/contents/repositories/enums/contents_language.enum.dart';

part 'youtube_contents_detail_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class YoutubeContentsDetailModel {
  YoutubeContentsDetailModel({
    required this.id,
    required this.title,
    required this.authorId,
    required this.relatedSkillIds,
    required this.relatedJobGroupIds,
    required this.contentsLanguageIds,
    required this.summary,
    required this.createdAt,
    required this.uploadAt,
    this.uploadUserId,
  });

  final String id;
  final String title;
  final String authorId;
  final List<String> relatedSkillIds;
  final List<String> relatedJobGroupIds;
  final List<String> contentsLanguageIds;
  final SummaryModel summary;
  final String? uploadUserId;

  @TimeStampConverter()
  final DateTime uploadAt;

  @TimeStampConverter()
  final DateTime createdAt;

  YoutubeContentsDetailEntity toEntity() {
    return YoutubeContentsDetailEntity(
      id: id,
      title: title,
      authorId: authorId,
      relatedSkillIds: relatedSkillIds.toSet(),
      relatedJobs: relatedJobGroupIds.map(JobGroup.getById).toSet(),
      contentsLanguage: contentsLanguageIds.map(ContentsLanguage.getById).toSet(),
      createdAt: createdAt,
      uploadAt: uploadAt,
      summary: summary.toEntity(),
      uploadUserId: uploadUserId,
    );
  }

  factory YoutubeContentsDetailModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      YoutubeContentsDetailModel.fromJson(snapshot.data()!);

  factory YoutubeContentsDetailModel.fromJson(Map<String, dynamic> json) {
    return _$YoutubeContentsDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$YoutubeContentsDetailModelToJson(this);
}
