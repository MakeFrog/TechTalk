import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/interview/data/local/interview_local_data_source.dart';
import 'package:techtalk/features/interview/repositories/interview_repository.dart';
import 'package:techtalk/features/interview/usecases/get_interview_topic_list_use_case.dart';

export 'data/local/interview_local_data_source.dart';
export 'entities/interview_topic_entity.dart';
export 'repositories/interview_repository.dart';
export 'usecases/get_interview_topic_list_use_case.dart';

final interviewRemoteDataSource = locator<InterviewLocalDataSource>();
final interviewRepository = locator<InterviewRepository>();
final getInterviewTopicListUseCase = locator<GetInterviewTopicListUseCase>();
