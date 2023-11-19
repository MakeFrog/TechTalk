import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/chat/repositories/chat_repository.dart';
import 'package:techtalk/features/chat/use_cases/get_answer_feedback_use_case.dart';
import 'package:techtalk/features/chat/use_cases/get_chat_list_use_case.dart';
import 'package:techtalk/features/chat/use_cases/get_question_ideal_answers_use_case.dart';
import 'package:techtalk/features/chat/use_cases/get_random_interview_question_use_case.dart';
import 'package:techtalk/features/chat/use_cases/retrieve_qna_list_from_chat_list_use_case.dart';

export 'chat.dart';
export 'entities/chat_entity.dart';
export 'entities/feedback_chat_entity.dart';
export 'entities/guide_chat_entity.dart';
export 'entities/interview_qna_entity.dart';
export 'entities/interview_question_entity.dart';
export 'entities/question_chat_entity.dart';
export 'entities/sent_chat_entity.dart';
export 'entities/user_interview_response.dart';
export 'enums/answer_state.enum.dart';
export 'enums/chat_type.enum.dart';
export 'enums/interview_progress_state.enum.dart';
export 'enums/interview_topic.enum.dart';
export 'enums/interview_topic_category.dart';
export 'enums/reply_state.enum.dart';
export 'repositories/chat_repository.dart';
export 'repositories/chat_repository_impl.dart';
export 'use_cases/get_answer_feedback_use_case.dart';
export 'use_cases/get_chat_list_use_case.dart';
export 'use_cases/get_question_ideal_answers_use_case.dart';
export 'use_cases/get_random_interview_question_use_case.dart';
export 'use_cases/retrieve_qna_list_from_chat_list_use_case.dart';

final chatRepository = locator<ChatRepository>();
final getChatListUseCase = locator<GetChatListUseCase>();
final getAnswerFeedBackUseCase = locator<GetAnswerFeedbackUseCase>();
final getQuestionIdealAnswersUseCase =
    locator<GetQuestionIdealAnswersUseCase>();
final retrieveQnaListFromChatListUseCase =
    locator<RetrieveQnaListFromChatListUseCase>();
final getRandomInterviewQuestionUseCase =
    locator<GetRandomInterviewQuestionUseCase>();
