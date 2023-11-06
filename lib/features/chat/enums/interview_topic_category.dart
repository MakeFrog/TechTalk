///
/// 인터뷰 주제 카테고리
///
enum InterviewTopicCategory {
  cs(id: 'c', text: 'CS'),
  technologyFrameworks(id: 'f', text: '기술 스택');

  final String id;
  final String text;

  const InterviewTopicCategory({required this.id, required this.text});
}
