import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/topic/data/local/topic_local_data_source.dart';
import 'package:techtalk/features/topic/data/remote/topic_remote_data_source.dart';
import 'package:techtalk/features/topic/repositories/topic_repository.dart';
import 'package:techtalk/features/topic/usecases/get_topic_questions_use_case.dart';
import 'package:techtalk/features/topic/usecases/get_topics_use_case.dart';
import 'package:techtalk/features/topic/usecases/search_topics_use_case.dart';

export 'data/local/topic_local_data_source.dart';
export 'data/models/topic_category_model.dart';
export 'data/models/topic_model.dart';
export 'data/models/topic_question_model.dart';
export 'data/remote/topic_remote_data_source.dart';
export 'entities/topic.enum.dart';
export 'entities/topic_category.enum.dart';
export 'entities/topic_question_entity.dart';
export 'repositories/topic_repository.dart';
export 'usecases/get_topic_questions_use_case.dart';
export 'usecases/get_topics_use_case.dart';
export 'usecases/search_topics_use_case.dart';

final topicLocalDataSource = locator<TopicLocalDataSource>();
final topicRemoteDataSource = locator<TopicRemoteDataSource>();
final topicRepository = locator<TopicRepository>();
final getTopicsUseCase = locator<GetTopicsUseCase>();
final searchTopicsUseCase = locator<SearchTopicsUseCase>();
final getTopicQuestionsUseCase = locator<GetTopicQuestionsUseCase>();
