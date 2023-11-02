import 'package:flutter/material.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/interview/interview.dart';
import 'package:techtalk/presentation/pages/main/tab_views/study/widgets/study_topic_card.dart';

class StudyTopicGridView extends StatelessWidget {
  const StudyTopicGridView({
    super.key,
    required this.topicList,
  });

  final List<InterviewTopicEntity> topicList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 11,
        mainAxisSpacing: 12,
      ),
      itemCount: topicList.length,
      itemBuilder: (context, index) {
        final topic = topicList[index];

        return StudyTopicCard(
          topic: topic,
          onTap: () {
            // TODO : 라우팅
            StudyRoute(topic.name).push(context);
          },
        );
      },
    );
  }
}
