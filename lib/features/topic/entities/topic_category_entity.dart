///
/// 인터뷰 주제 카테고리
///
class TopicCategoryEntity {
  final String id;
  final String text;

//<editor-fold desc="Data Methods">
  const TopicCategoryEntity({
    required this.id,
    required this.text,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TopicCategoryEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text);

  @override
  int get hashCode => id.hashCode ^ text.hashCode;

  @override
  String toString() {
    return 'TopicCategoryEntity{' + ' id: $id,' + ' text: $text,' + '}';
  }

  TopicCategoryEntity copyWith({
    String? id,
    String? text,
  }) {
    return TopicCategoryEntity(
      id: id ?? this.id,
      text: text ?? this.text,
    );
  }

//</editor-fold>
}
