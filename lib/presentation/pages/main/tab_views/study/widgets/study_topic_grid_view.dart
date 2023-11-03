import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        crossAxisCount: ScreenUtil().screenWidth < 800 ? 2 : 3,
        crossAxisSpacing: 11.w,
        mainAxisSpacing: 12.w,
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
