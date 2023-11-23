import 'package:flutter/material.dart';
import 'package:techtalk/features/chat/chat.dart';

class StudyTopicGridView extends StatelessWidget {
  const StudyTopicGridView({
    super.key,
    required this.topicList,
    required this.topicCardBuilder,
  });

  final List<InterviewTopic> topicList;
  final IndexedWidgetBuilder topicCardBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 11,
        mainAxisSpacing: 12,
      ),
      itemCount: topicList.length,
      itemBuilder: topicCardBuilder,
    );
  }
}
