import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/features/topic/data_source/local/topic_local_data_source.dart';
import 'package:techtalk/features/topic/data_source/remote/topic_remote_data_source.dart';
import 'package:techtalk/features/topic/repositories/topic_repository.dart';
import 'package:techtalk/features/topic/usecases/get_categorized_topics_use_case.dart';
import 'package:techtalk/features/topic/usecases/get_topic_qna_use_case.dart';
import 'package:techtalk/features/topic/usecases/get_topic_qnas_use_case.dart';
import 'package:techtalk/features/topic/usecases/get_topics_use_case.dart';

export 'data_source/local/topic_local_data_source.dart';
export 'data_source/remote/models/topic_category_model.dart';
export 'data_source/remote/models/topic_model.dart';
export 'data_source/remote/models/topic_qna_model.dart';
export 'data_source/remote/topic_remote_data_source.dart';
export 'repositories/entities/qna_entity.dart';
export 'repositories/entities/topic_category_entity.dart';
export 'repositories/entities/topic_entity.dart';
export 'repositories/topic_repository.dart';
export 'usecases/get_categorized_topics_use_case.dart';
export 'usecases/get_topic_qna_use_case.dart';
export 'usecases/get_topic_qnas_use_case.dart';
export 'usecases/get_topics_use_case.dart';

final topicLocalDataSource = locator<TopicLocalDataSource>();
final topicRemoteDataSource = locator<TopicRemoteDataSource>();
final topicRepository = locator<TopicRepository>();
final getTopicsUseCase = locator<GetTopicsUseCase>();
final getCategorizedTopicsUseCase = locator<GetCategorizedTopicsUseCase>();

final getTopicQnasUseCase = locator<GetTopicQnasUseCase>();
final getTopicQnaUseCase = locator<GetTopicQnaUseCase>();
