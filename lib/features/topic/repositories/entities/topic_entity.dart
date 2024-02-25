class TopicEntity {
  final String id;
  final String text;
  final String? imageUrl;
  final List<String> skillIds;
  final String categoryId;
  final bool isAvailable;
  final DateTime updatedAt;

//<editor-fold desc="Data Methods">
  const TopicEntity({
    required this.id,
    required this.text,
    this.imageUrl,
    required this.skillIds,
    required this.categoryId,
    required this.isAvailable,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'text': this.text,
      'imageUrl': this.imageUrl,
      'skillIds': this.skillIds,
      'categoryId': this.categoryId,
      'isAvailable': this.isAvailable,
      'updatedAt': this.updatedAt,
    };
  }

  factory TopicEntity.fromMap(Map<String, dynamic> map) {
    return TopicEntity(
      id: map['id'] as String,
      text: map['text'] as String,
      imageUrl: map['imageUrl'] as String,
      skillIds: map['skillIds'] as List<String>,
      categoryId: map['categoryId'] as String,
      isAvailable: map['isAvailable'] as bool,
      updatedAt: map['updatedAt'] as DateTime,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopicEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          imageUrl == other.imageUrl &&
          skillIds == other.skillIds &&
          categoryId == other.categoryId &&
          isAvailable == other.isAvailable &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      text.hashCode ^
      imageUrl.hashCode ^
      skillIds.hashCode ^
      categoryId.hashCode ^
      isAvailable.hashCode ^
      updatedAt.hashCode;

  TopicEntity copyWith({
    String? id,
    String? text,
    String? imageUrl,
    List<String>? skillIds,
    String? categoryId,
    bool? isAvailable,
    DateTime? updatedAt,
  }) {
    return TopicEntity(
      id: id ?? this.id,
      text: text ?? this.text,
      imageUrl: imageUrl ?? this.imageUrl,
      skillIds: skillIds ?? this.skillIds,
      categoryId: categoryId ?? this.categoryId,
      isAvailable: isAvailable ?? this.isAvailable,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
