import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/core/modules/converter/time_stamp_converter.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/features/blog/repository/entity/blog_shell_entity.dart';

part 'blog_main_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class BlogMainModel {
  BlogMainModel({
    this.id = 'undefined',
    this.blogId = 'undefined',
    this.blogName = '블로그 없음',
    this.title = '제목없음',
    this.description = '',
    this.author = '',
    this.linkUrl = '',
    this.thumbnailUrl = '',
    this.createdAt,
    this.updatedAt,
    this.publishDate,
    this.isValid = false,
    this.relatedSkillIds = const [],
    this.relatedJobGroupIds = const [],
  });

  final String id;
  final String blogId;
  final String blogName;
  final String title;
  final String description;
  final String author;
  final String linkUrl;
  final String thumbnailUrl;

  @TimeStampConverter()
  final DateTime? createdAt;

  @TimeStampConverter()
  final DateTime? updatedAt;

  @TimeStampConverter()
  final DateTime? publishDate;

  final bool isValid;
  final List<String> relatedSkillIds;
  final List<String> relatedJobGroupIds;

  /// 엔티티로 변환
  BlogShellEntity toEntity(
    Set<SkillEntity> skills,
    Set<JobGroupEntity> jobGroups,
  ) {
    return BlogShellEntity(
      id: id,
      blogId: blogId,
      blogName: blogName,
      title: title,
      description: description,
      author: author,
      linkUrl: linkUrl,
      thumbnailUrl: thumbnailUrl,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      publishDate: publishDate ?? DateTime.now(),
      isValid: isValid,
      skillIds: relatedSkillIds,
      jobGroupIds: relatedJobGroupIds,
      relatedSkills: skills,
      relatedJobGroups: jobGroups,
    );
  }

  /// Firestore에서 가져온 DocumentSnapshot을 모델로 변환
  factory BlogMainModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return BlogMainModel.fromJson(snapshot.data()!);
  }

  /// JSON에서 모델로 변환
  factory BlogMainModel.fromJson(Map<String, dynamic> json) =>
      _$BlogMainModelFromJson(json);

  Map<String, dynamic> toFirestore() {
    final data = toJson();
    data['random'] = {
      '1': Random().nextDouble(),
      '2': Random().nextDouble(),
      '3': Random().nextDouble(),
      '4': Random().nextDouble(),
      '5': Random().nextDouble(),
    };
    return data;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'blog_id': blogId,
      'blog_name': blogName,
      'title': title,
      'description': description,
      'author': author,
      'link_url': linkUrl,
      'thumbnail_url': thumbnailUrl,
      'created_at':
          const TimeStampConverter().toJson(createdAt ?? DateTime.now()),
      'updated_at':
          const TimeStampConverter().toJson(updatedAt ?? DateTime.now()),
      'publish_date':
          const TimeStampConverter().toJson(publishDate ?? DateTime.now()),
      'is_valid': isValid,
      'related_skills': relatedSkillIds,
      'related_job_groups': relatedJobGroupIds,
    };
  }

  BlogMainModel copyWith({
    String? id,
    String? blogId,
    String? blogName,
    String? title,
    String? description,
    String? author,
    String? linkUrl,
    String? thumbnailUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? publishDate,
    bool? isValid,
    List<String>? relatedSkillIds,
    List<String>? relatedJobGroupIds,
  }) {
    return BlogMainModel(
      id: id ?? this.id,
      blogId: blogId ?? this.blogId,
      blogName: blogName ?? this.blogName,
      title: title ?? this.title,
      description: description ?? this.description,
      author: author ?? this.author,
      linkUrl: linkUrl ?? this.linkUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      publishDate: publishDate ?? this.publishDate,
      isValid: isValid ?? this.isValid,
      relatedSkillIds: relatedSkillIds ?? this.relatedSkillIds,
      relatedJobGroupIds: relatedJobGroupIds ?? this.relatedJobGroupIds,
    );
  }
}
