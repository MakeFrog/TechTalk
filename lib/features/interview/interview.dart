import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/interview/data/local/interview_local_data_source.dart';
import 'package:techtalk/features/interview/data/remote/interview_remote_data_source.dart';
import 'package:techtalk/features/interview/repositories/interview_repository.dart';
import 'package:techtalk/features/interview/usecases/get_interview_topics_use_case.dart';
import 'package:techtalk/features/interview/usecases/get_review_note_question_list_use_case.dart';

export 'data/local/interview_local_data_source.dart';
export 'data/remote/interview_remote_data_source.dart';
export 'repositories/interview_repository.dart';
export 'usecases/get_interview_topics_use_case.dart';

final interviewRemoteDataSource = locator<InterviewRemoteDataSource>();
final interviewLocalDataSource = locator<InterviewLocalDataSource>();
final interviewRepository = locator<InterviewRepository>();
final getInterviewTopicListUseCase = locator<GetInterviewTopicsUseCase>();
final getReviewNoteQuestionListUseCase =
    locator<GetReviewNoteQuestionListUseCase>();
