import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/topic/data/local/interview_topic_local_data_source.dart';
import 'package:techtalk/features/topic/repositories/topic_repository.dart';
import 'package:techtalk/features/topic/usecases/get_topics_use_case.dart';
import 'package:techtalk/features/topic/usecases/search_interview_topics_use_case.dart';

export 'entities/topic.enum.dart';
export 'entities/topic_category.enum.dart';
export 'repositories/topic_repository.dart';
export 'usecases/get_topics_use_case.dart';
export 'usecases/search_interview_topics_use_case.dart';

final topicLocalDataSource = locator<InterviewTopicLocalDataSource>();
final topicRepository = locator<TopicRepository>();
final getTopicsUseCase = locator<GetTopicsUseCase>();
final searchTopicsUseCase = locator<SearchInterviewTopicsUseCase>();
