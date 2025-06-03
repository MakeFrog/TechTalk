abstract class BlogBaseEntity {
  final String id;
  final String blogId;
  final String blogName;
  final String title;
  final String description;
  final String author;
  final String linkUrl;
  final String thumbnailUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishDate;
  final bool isValid;
  final List<String> skillIds;
  final List<String> jobGroupIds;

  const BlogBaseEntity({
    required this.id,
    required this.blogId,
    required this.blogName,
    required this.title,
    required this.description,
    required this.author,
    required this.linkUrl,
    required this.thumbnailUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.publishDate,
    required this.isValid,
    required this.skillIds,
    required this.jobGroupIds,
  });
}
