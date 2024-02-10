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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TopicEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          imageUrl == other.imageUrl &&
          categoryId == other.categoryId &&
          isAvailable == other.isAvailable &&
          updatedAt == other.updatedAt);

  @override
  int get hashCode =>
      id.hashCode ^
      text.hashCode ^
      imageUrl.hashCode ^
      categoryId.hashCode ^
      isAvailable.hashCode ^
      updatedAt.hashCode;

  @override
  String toString() {
    return 'TopicEntity{' +
        ' id: $id,' +
        ' text: $text,' +
        ' imageUrl: $imageUrl,' +
        ' categoryId: $categoryId,' +
        ' isAvailable: $isAvailable,' +
        ' updatedAt: $updatedAt,' +
        '}';
  }

  TopicEntity copyWith({
    String? id,
    String? text,
    String? imageUrl,
    String? categoryId,
    bool? isAvailable,
    DateTime? updatedAt,
    List<String>? skillIds,
  }) {
    return TopicEntity(
      id: id ?? this.id,
      text: text ?? this.text,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryId: categoryId ?? this.categoryId,
      isAvailable: isAvailable ?? this.isAvailable,
      updatedAt: updatedAt ?? this.updatedAt,
      skillIds: skillIds ?? this.skillIds,
    );
  }

//</editor-fold>
}
