// import 'package:techtalk/core/core.dart';
// import 'package:techtalk/features/interview/entities/interview_topic_category.enum.dart';
//
// ///
// /// 인터뷰 주제
// ///
// enum InterviewTopic {
//   java(
//     id: 'java',
//     text: 'Java',
//     imageUrl: Assets.imagesTopicJava,
//     category: InterviewTopicCategory.language,
//   ),
//   spring(
//     id: 'spring',
//     text: 'Spring',
//     imageUrl: Assets.imagesTopicSpring,
//     category: InterviewTopicCategory.framework,
//   ),
//   react(
//     id: 'react',
//     text: 'React',
//     imageUrl: Assets.imagesTopicReact,
//     category: InterviewTopicCategory.framework,
//     isAvailable: true,
//   ),
//   swift(
//     id: 'swift',
//     text: 'Swift/iOS',
//     imageUrl: Assets.imagesTopicSwift,
//     category: InterviewTopicCategory.framework,
//   ),
//   flutter(
//     id: 'flutter',
//     text: 'Flutter/Dart',
//     imageUrl: Assets.imagesTopicFlutter,
//     category: InterviewTopicCategory.framework,
//     isAvailable: true,
//   ),
//   android(
//     id: 'android',
//     text: 'Android',
//     imageUrl: Assets.imagesTopicAndroid,
//     category: InterviewTopicCategory.framework,
//   ),
//   dataStructure(
//     id: 'dataStructure',
//     text: '자료구조',
//     imageUrl: Assets.imagesTopicDataStructure,
//     category: InterviewTopicCategory.cs,
//   ),
//   operatingSystem(
//     id: 'operatingSystem',
//     text: '운영체제',
//     imageUrl: Assets.imagesTopicOperatingSystem,
//     category: InterviewTopicCategory.cs,
//   );
//
//   final String id;
//   final String text;
//   final String? imageUrl;
//   final InterviewTopicCategory category;
//   final bool isAvailable;
//
//   static InterviewTopic getTopicById(String id) {
//     return values.firstWhere(
//       (topic) => topic.id == id,
//       orElse: () => throw Exception('Unexpected Topic Id Value'),
//     );
//   }
//
//   const InterviewTopic({
//     required this.id,
//     required this.text,
//     this.imageUrl,
//     required this.category,
//     this.isAvailable = false,
//   });
// }
