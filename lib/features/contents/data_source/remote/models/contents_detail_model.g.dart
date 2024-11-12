// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contents_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentsDetailModel _$ContentsDetailModelFromJson(Map<String, dynamic> json) =>
    ContentsDetailModel(
      id: json['id'] as String,
      contentsId: json['contents_id'] as String,
      title: json['title'] as String,
      authorId: json['author_id'] as String,
      relatedSkills: (json['related_skills'] as List<dynamic>)
          .map((e) => SkillModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      relatedJobGroupIds: (json['related_job_group_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      contentsLanguageIds: (json['contents_language_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      relatedQna: (json['related_qna'] as List<dynamic>)
          .map((e) => TopicQnaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: SummaryModel.fromJson(json['summary'] as Map<String, dynamic>),
      uploadUserId: json['upload_user_id'] as String?,
    );

Map<String, dynamic> _$ContentsDetailModelToJson(
        ContentsDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contents_id': instance.contentsId,
      'title': instance.title,
      'author_id': instance.authorId,
      'related_skills': instance.relatedSkills.map((e) => e.toJson()).toList(),
      'related_job_group_ids': instance.relatedJobGroupIds,
      'contents_language_ids': instance.contentsLanguageIds,
      'related_qna': instance.relatedQna.map((e) => e.toJson()).toList(),
      'summary': instance.summary.toJson(),
      'upload_user_id': instance.uploadUserId,
    };
