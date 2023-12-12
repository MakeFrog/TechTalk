import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/interview/usecases/get_interview_questions_use_case.dart';
import 'package:techtalk/features/interview_new/question/data/local/interview_question_local_data_source.dart';
import 'package:techtalk/features/interview_new/question/data/remote/interview_question_remote_data_source.dart';
import 'package:techtalk/features/interview_new/question/repositories/interview_question_repository.dart';
import 'package:techtalk/features/interview_new/question/usecases/get_interview_answers_use_case.dart';
import 'package:techtalk/features/interview_new/question/usecases/get_interview_question_use_case.dart';
import 'package:techtalk/features/interview_new/question/usecases/get_random_interview_question_use_case.dart';

export 'entities/interview_answer_entity.dart';
export 'entities/interview_question_entity.dart';
export 'usecases/get_interview_answers_use_case.dart';
export 'usecases/get_interview_question_use_case.dart';
export 'usecases/get_interview_questions_use_case.dart';
export 'usecases/get_random_interview_question_use_case.dart';

final interviewQuestionRemoteDataSource =
    locator<InterviewQuestionRemoteDataSource>();
final interviewQuestionLocalDataSource =
    locator<InterviewQuestionLocalDataSource>();
final interviewQuestionRepository = locator<InterviewQuestionRepository>();
final getInterviewQuestionsUseCase = locator<GetInterviewQuestionsUseCase>();
final getInterviewAnswersUseCase = locator<GetInterviewAnswersUseCase>();
final getInterviewQuestionUseCase = locator<GetInterviewQuestionUseCase>();
final getRandomInterviewQuestionUseCase =
    locator<GetRandomInterviewQuestionUseCase>();
