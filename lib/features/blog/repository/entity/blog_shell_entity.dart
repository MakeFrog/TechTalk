import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/features/blog/repository/entity/blog_base_entity.dart';
import 'package:techtalk/features/tech_set/repositories/enums/skill_category.enum.dart';

class BlogShellEntity extends BlogBaseEntity {
  final Set<SkillEntity> relatedSkills;
  final Set<JobGroupEntity> relatedJobGroups;

  const BlogShellEntity({
    required super.id,
    required super.blogId,
    required super.blogName,
    required super.title,
    required super.description,
    required super.author,
    required super.linkUrl,
    required super.thumbnailUrl,
    required super.createdAt,
    required super.updatedAt,
    required super.publishDate,
    required super.isValid,
    required super.skillIds,
    required super.jobGroupIds,
    required this.relatedSkills,
    required this.relatedJobGroups,
  });

  factory BlogShellEntity.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;

    return BlogShellEntity(
      id: data['id'] as String,
      blogId: data['blog_id'] as String,
      blogName: data['blog_name'] as String,
      title: data['title'] as String,
      description: data['description'] as String,
      author: data['author'] as String,
      linkUrl: data['link_url'] as String,
      thumbnailUrl: data['thumbnail_url'] as String,
      createdAt: (data['created_at'] as Timestamp).toDate(),
      updatedAt: (data['updated_at'] as Timestamp).toDate(),
      publishDate: (data['publish_date'] as Timestamp).toDate(),
      isValid: data['is_valid'] as bool? ?? false,
      skillIds: List<String>.from(data['related_skills'] ?? []),
      jobGroupIds: List<String>.from(data['related_job_groups'] ?? []),
      relatedSkills: const {}, // 실제 스킬 데이터는 나중에 처리
      relatedJobGroups: const {}, // 실제 직군 데이터는 나중에 처리
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'blog_id': blogId,
      'blog_name': blogName,
      'title': title,
      'description': description,
      'author': author,
      'link_url': linkUrl,
      'thumbnail_url': thumbnailUrl,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': Timestamp.fromDate(updatedAt),
      'publish_date': Timestamp.fromDate(publishDate),
      'is_valid': isValid,
      'related_skills': skillIds,
      'related_job_groups': jobGroupIds,
    };
  }
}
