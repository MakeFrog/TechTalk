import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/interview/data/models/interview_topic_model.dart';
import 'package:techtalk/features/interview/interview.dart';

class InterviewLocalDataSourceImpl implements InterviewLocalDataSource {
  @override
  List<InterviewTopicModel> getInterviewTopicList() {
    const react = InterviewTopicModel(
      name: 'React',
      topicImageUrl: Assets.imagesTopicReact,
    );
    const swift = InterviewTopicModel(
      name: 'Swift',
      topicImageUrl: Assets.imagesTopicSwift,
    );
    const flutter = InterviewTopicModel(
      name: 'Flutter',
      topicImageUrl: Assets.imagesTopicFlutter,
    );
    const ios = InterviewTopicModel(
      name: 'iOS',
      topicImageUrl: Assets.imagesTopicIos,
    );
    const java = InterviewTopicModel(
      name: 'Java',
      topicImageUrl: Assets.imagesTopicJava,
    );
    const dataStructure = InterviewTopicModel(
      name: '자료구조',
      topicImageUrl: Assets.imagesTopicDataStructure,
    );
    const android = InterviewTopicModel(
      name: 'Android',
      topicImageUrl: Assets.imagesTopicAndroid,
    );
    const spring = InterviewTopicModel(
      name: 'Spring',
      topicImageUrl: Assets.imagesTopicSpring,
    );
    const nestJs = InterviewTopicModel(
      name: 'nest js',
      topicImageUrl: '',
    );
    const os = InterviewTopicModel(
      name: '운영체제',
      topicImageUrl: Assets.imagesTopicOperatingSystem,
    );

    return [
      react,
      swift,
      flutter,
      ios,
      java,
      dataStructure,
      android,
      spring,
      nestJs,
      os,
    ];
  }
}
