import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/features/contents/data_source/remote/models/skill_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/summary_model.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_contents_detail_entity.dart';
import 'package:techtalk/features/contents/repositories/enums/contents_language.enum.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'youtube_contents_detail_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class YoutubeContentsDetailModel {
  YoutubeContentsDetailModel({
    required this.id,
    required this.title,
    required this.authorId,
    required this.relatedSkills,
    required this.relatedJobGroupIds,
    required this.contentsLanguageIds,
    required this.summary,
    this.uploadUserId,
  });

  final String id;
  final String title;
  final String authorId;
  final List<SkillModel> relatedSkills;
  final List<String> relatedJobGroupIds;
  final List<String> contentsLanguageIds;
  final SummaryModel summary;
  final String? uploadUserId;

  YoutubeContentsDetailEntity toEntity() {
    return YoutubeContentsDetailEntity(
      id: id,
      title: title,
      authorId: authorId,
      relatedSkills: relatedSkills.map((skill) => skill.toEntity()).toSet(),
      relatedJobs: relatedJobGroupIds.map(JobGroup.getById).toSet(),
      contentsLanguage: contentsLanguageIds.map(ContentsLanguage.getById).toSet(),
      summary: summary.toEntity(),
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
