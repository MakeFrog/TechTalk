import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/features/topic/data_source/local/topic_local_data_source.dart';
import 'package:techtalk/features/topic/data_source/remote/topic_remote_data_source.dart';
import 'package:techtalk/features/topic/repositories/topic_repository.dart';
import 'package:techtalk/features/topic/usecases/get_topic_qnas_use_case.dart';
import 'package:techtalk/features/topic/usecases/get_wrong_answers_use_case.dart';
import 'package:techtalk/features/topic/usecases/update_wrong_answer_use_case.dart';

export 'data_source/local/boxes/qna_box.dart';
export 'data_source/local/boxes/qna_list_box.dart';
export 'data_source/local/topic_local_data_source.dart';
export 'data_source/local/topic_local_data_source_impl.dart';
export 'data_source/remote/models/topic_category_model.dart';
export 'data_source/remote/models/topic_model.dart';
export 'data_source/remote/models/topic_qna_model.dart';
export 'data_source/remote/models/wrong_answer_model.dart';
export 'data_source/remote/topic_remote_data_source.dart';
export 'data_source/remote/topic_remote_data_source_impl.dart';
export 'data_source/remote/topics_ref.dart';
export 'repositories/entities/qna_entity.dart';
export 'repositories/entities/topic_category_entity.dart';
export 'repositories/entities/topic_entity.dart';
export 'repositories/entities/wrong_answer_entity.dart';
export 'repositories/topic_repository.dart';
export 'repositories/topic_repository_impl.dart';
export 'topic.dart';
export 'usecases/get_topic_qnas_use_case.dart';
export 'usecases/get_wrong_answers_use_case.dart';
export 'usecases/update_wrong_answer_use_case.dart';

final topicLocalDataSource = locator<TopicLocalDataSource>();
final topicRemoteDataSource = locator<TopicRemoteDataSource>();
final topicRepository = locator<TopicRepository>();
final updateWrongAnswerUSeCase = locator<UpdateWrongAnswerUseCase>();
final getWrongAnswersUseCase = locator<GetWrongAnswersUseCase>();
final getTopicQnasUseCase = locator<GetTopicQnasUseCase>();
