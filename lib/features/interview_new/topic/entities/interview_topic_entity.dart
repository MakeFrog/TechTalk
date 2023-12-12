import 'package:techtalk/features/interview_new/topic/interview_topic.dart';

class InterviewTopicEntity {
  final String id;
  final String text;
  final String? imageUrl;
  final InterviewTopicCategoryEntity category;
  final bool isAvailable;

//<editor-fold desc="Data Methods">
  const InterviewTopicEntity({
    required this.id,
    required this.text,
    this.imageUrl,
    required this.category,
    required this.isAvailable,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InterviewTopicEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          imageUrl == other.imageUrl &&
          category == other.category &&
          isAvailable == other.isAvailable);

  @override
  int get hashCode =>
      id.hashCode ^
      text.hashCode ^
      imageUrl.hashCode ^
      category.hashCode ^
      isAvailable.hashCode;

  @override
  String toString() {
    return 'InterviewTopicEntity{' +
        ' id: $id,' +
        ' text: $text,' +
        ' imageUrl: $imageUrl,' +
        ' category: $category,' +
        ' isAvailable: $isAvailable,' +
        '}';
  }

  InterviewTopicEntity copyWith({
    String? id,
    String? text,
    String? imageUrl,
    InterviewTopicCategoryEntity? category,
    bool? isAvailable,
  }) {
    return InterviewTopicEntity(
      id: id ?? this.id,
      text: text ?? this.text,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'text': this.text,
      'imageUrl': this.imageUrl,
      'category': this.category,
      'isAvailable': this.isAvailable,
    };
  }

  factory InterviewTopicEntity.fromMap(Map<String, dynamic> map) {
    return InterviewTopicEntity(
      id: map['id'] as String,
      text: map['text'] as String,
      imageUrl: map['imageUrl'] as String,
      category: map['category'] as InterviewTopicCategoryEntity,
      isAvailable: map['isAvailable'] as bool,
    );
  }

//</editor-fold>
}
