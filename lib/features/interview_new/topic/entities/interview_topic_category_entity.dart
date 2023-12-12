class InterviewTopicCategoryEntity {
  final String id;
  final String text;

//<editor-fold desc="Data Methods">
  const InterviewTopicCategoryEntity({
    required this.id,
    required this.text,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InterviewTopicCategoryEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text);

  @override
  int get hashCode => id.hashCode ^ text.hashCode;

  @override
  String toString() {
    return 'InterviewTopicCategoryEntity{' +
        ' id: $id,' +
        ' text: $text,' +
        '}';
  }

  InterviewTopicCategoryEntity copyWith({
    String? id,
    String? text,
  }) {
    return InterviewTopicCategoryEntity(
      id: id ?? this.id,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'text': this.text,
    };
  }

  factory InterviewTopicCategoryEntity.fromMap(Map<String, dynamic> map) {
    return InterviewTopicCategoryEntity(
      id: map['id'] as String,
      text: map['text'] as String,
    );
  }

//</editor-fold>
}
