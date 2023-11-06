import 'package:techtalk/features/chat/enums/interview_topic_category.dart';

///
/// 인터뷰 주제
///
enum InterviewTopic {
  swift(
    id: 'swift',
    text: 'Swift/iOS',
    category: InterviewTopicCategory.technologyFrameworks,
  ),
  flutter(
    id: 'flutter',
    text: 'Flutter/Dart',
    category: InterviewTopicCategory.technologyFrameworks,
  );

  final String id;
  final String text;
  final InterviewTopicCategory category;

  const InterviewTopic({
    required this.id,
    required this.text,
    required this.category,
  });
}
