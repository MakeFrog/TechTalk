import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/topic/entities/topic_category.enum.dart';

///
/// 인터뷰 주제
///
enum Topic {
  java(
    id: 'java',
    text: 'Java',
    imageUrl: Assets.imagesTopicJava,
    category: TopicCategory.programmingLanguage,
  ),
  spring(
    id: 'spring',
    text: 'Spring',
    imageUrl: Assets.imagesTopicSpring,
    category: TopicCategory.technologyFrameworks,
  ),
  react(
    id: 'react',
    text: 'React',
    imageUrl: Assets.imagesTopicReact,
    category: TopicCategory.technologyFrameworks,
    isAvailable: true,
  ),
  swift(
    id: 'swift',
    text: 'Swift/iOS',
    imageUrl: Assets.imagesTopicSwift,
    category: TopicCategory.technologyFrameworks,
  ),
  flutter(
    id: 'flutter',
    text: 'Flutter/Dart',
    imageUrl: Assets.imagesTopicFlutter,
    category: TopicCategory.technologyFrameworks,
    isAvailable: true,
  ),
  android(
    id: 'android',
    text: 'Android',
    imageUrl: Assets.imagesTopicAndroid,
    category: TopicCategory.technologyFrameworks,
  ),
  dataStructure(
    id: 'dataStructure',
    text: '자료구조',
    imageUrl: Assets.imagesTopicDataStructure,
    category: TopicCategory.cs,
  ),
  operatingSystem(
    id: 'operatingSystem',
    text: '운영체제',
    imageUrl: Assets.imagesTopicOperatingSystem,
    category: TopicCategory.cs,
  );

  final String id;
  final String text;
  final String? imageUrl;
  final TopicCategory category;
  final bool isAvailable;

  static Topic getTopicById(String id) {
    return values.firstWhere(
      (topic) => topic.id == id,
      orElse: () => throw Exception('Unexpected Topic Id Value'),
    );
  }

  const Topic({
    required this.id,
    required this.text,
    this.imageUrl,
    required this.category,
    this.isAvailable = false,
  });
}
