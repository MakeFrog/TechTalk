import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/interview/usecases/get_interview_topics_use_case.dart';
import 'package:techtalk/features/interview_new/topic/data/local/interview_topic_local_data_source.dart';
import 'package:techtalk/features/interview_new/topic/repositories/interview_topic_repository.dart';

export 'entities/interview_topic_category_entity.dart';
export 'entities/interview_topic_entity.dart';
export 'usecases/get_interview_topics_use_case.dart';

final interviewTopicLocalDataSource = locator<InterviewTopicLocalDataSource>();
final interviewTopicRepository = locator<InterviewTopicRepository>();
final getInterviewTopicsUseCase = locator<GetInterviewTopicListUseCase>();
