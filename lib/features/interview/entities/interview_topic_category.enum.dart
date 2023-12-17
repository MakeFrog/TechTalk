///
/// 인터뷰 주제 카테고리
///
enum TopicCategory {
  cs(id: 'cs', text: 'CS'),
  framework(id: 'framework', text: '기술 스택'),
  language(id: 'language', text: '개발 언어');

  final String id;
  final String text;

  const TopicCategory({required this.id, required this.text});

  static TopicCategory getById(String id) {
    return values.firstWhere(
      (category) {
        return category.id == id;
      },
      orElse: () {
        throw Exception('Unexpected Category Id Value');
      },
    );
  }
}
