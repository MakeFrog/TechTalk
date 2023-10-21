import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/interview/data/models/interview_topic_model.dart';
import 'package:techtalk/features/interview/interview.dart';

class InterviewLocalDataSourceImpl implements InterviewLocalDataSource {
  @override
  List<InterviewTopicModel> getInterviewTopicList() {
    const react = InterviewTopicModel(
      name: 'React',
      category: 'Framework',
      topicImageUrl: Assets.imagesTopicReact,
    );
    const swift = InterviewTopicModel(
      name: 'Swift',
      category: 'Language',
      topicImageUrl: Assets.imagesTopicSwift,
    );
    const flutter = InterviewTopicModel(
      name: 'Flutter',
      category: 'Framework',
      topicImageUrl: Assets.imagesTopicFlutter,
    );
    const ios = InterviewTopicModel(
      name: 'iOS',
      category: 'OS',
      topicImageUrl: Assets.imagesTopicIos,
    );
    const java = InterviewTopicModel(
      name: 'Java',
      category: 'Language',
      topicImageUrl: Assets.imagesTopicJava,
    );
    const dataStructure = InterviewTopicModel(
      name: '자료구조',
      category: 'CS',
      topicImageUrl: Assets.imagesTopicDataStructure,
    );
    const android = InterviewTopicModel(
      name: 'Android',
      category: 'Framework',
      topicImageUrl: Assets.imagesTopicAndroid,
    );
    const spring = InterviewTopicModel(
      name: 'Spring',
      category: 'Framework',
      topicImageUrl: Assets.imagesTopicSpring,
    );
    const nestJs = InterviewTopicModel(
      name: 'nest js',
      category: 'Framework',
      topicImageUrl: Assets.imagesTopicNestJs,
    );
    const os = InterviewTopicModel(
      name: '운영체제',
      category: 'CS',
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
