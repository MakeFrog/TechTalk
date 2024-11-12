import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/features/contents/contents.dart';
import 'package:techtalk/features/contents/data_source/remote/models/skill_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/summary_model.dart';
import 'package:techtalk/features/contents/repositories/enums/contents_language.enum.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'contents_detail_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ContentsDetailModel {
  ContentsDetailModel({
    required this.id,
    required this.contentsId,
    required this.title,
    required this.authorId,
    required this.relatedSkills,
    required this.relatedJobGroupIds,
    required this.contentsLanguageIds,
    required this.relatedQna,
    required this.summary,
    this.uploadUserId,
  });

  final String id;
  final String contentsId;
  final String title;
  final String authorId;
  final List<SkillModel> relatedSkills;
  final List<String> relatedJobGroupIds;
  final List<String> contentsLanguageIds;
  final List<TopicQnaModel> relatedQna;
  final SummaryModel summary;
  final String? uploadUserId;

  ContentsDetailEntity toEntity() {
    return ContentsDetailEntity(
      id: id,
      contentsId: contentsId,
      title: title,
      authorId: authorId,
      relatedSkills: relatedSkills.map((skill) => skill.toEntity()).toSet(),
      relatedJobs: relatedJobGroupIds.map(JobGroup.getById).toSet(),
      contentsLanguage: contentsLanguageIds.map(ContentsLanguage.getById).toSet(),
      relatedQna: relatedQna.map((qna) => qna.toEntity()).toList(),
      summary: summary.toEntity(),
    );
  }

  factory ContentsDetailModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      ContentsDetailModel.fromJson(snapshot.data()!);

  factory ContentsDetailModel.fromJson(Map<String, dynamic> json) {
    return _$ContentsDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ContentsDetailModelToJson(this);
}
