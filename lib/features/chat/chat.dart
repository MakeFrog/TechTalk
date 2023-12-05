import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/chat/data/remote/chat_remote_data_source.dart';
import 'package:techtalk/features/chat/repositories/chat_repository.dart';
import 'package:techtalk/features/chat/use_cases/get_answer_feedback_use_case.dart';
import 'package:techtalk/features/chat/use_cases/get_chat_messages_use_case.dart';
import 'package:techtalk/features/chat/use_cases/get_chat_rooms_use_case.dart';
import 'package:techtalk/features/chat/use_cases/get_question_ideal_answers_use_case.dart';
import 'package:techtalk/features/chat/use_cases/get_random_interview_question_use_case.dart';
import 'package:techtalk/features/chat/use_cases/retrieve_qna_list_from_chat_list_use_case.dart';
import 'package:techtalk/features/chat/use_cases/update_chat_info_use_case.dart';

export '../interview/entities/interview_topic.enum.dart';
export '../interview/entities/interview_topic_category.enum.dart';
export 'chat.dart';
export 'repositories/chat_repository.dart';
export 'repositories/chat_repository_impl.dart';
export 'repositories/entities/chat_room_entity.dart';
export 'repositories/entities/feedback_message_entity.dart';
export 'repositories/entities/guide_message_entity.dart';
export 'repositories/entities/interview_qna_entity.dart';
export 'repositories/entities/interview_question_entity.dart';
export 'repositories/entities/message_entity.dart';
export 'repositories/entities/question_message_entity.dart';
export 'repositories/entities/sent_message_entity.dart';
export 'repositories/entities/user_interview_response.dart';
export 'repositories/enums/answer_state.enum.dart';
export 'repositories/enums/chat_type.enum.dart';
export 'repositories/enums/interview_progress_state.enum.dart';
export 'repositories/enums/pass_or_fail.enum.dart';
export 'repositories/enums/reply_state.enum.dart';
export 'use_cases/get_answer_feedback_use_case.dart';
export 'use_cases/get_chat_messages_use_case.dart';
export 'use_cases/get_chat_rooms_use_case.dart';
export 'use_cases/get_question_ideal_answers_use_case.dart';
export 'use_cases/get_random_interview_question_use_case.dart';
export 'use_cases/retrieve_qna_list_from_chat_list_use_case.dart';

final chatRemoteDataSource = locator<ChatRemoteDataSource>();
final chatRepository = locator<ChatRepository>();
final getChatMessagesUseCase = locator<GetChatMessagesUseCase>();
final getAnswerFeedBackUseCase = locator<GetAnswerFeedbackUseCase>();
final getQuestionIdealAnswersUseCase =
    locator<GetQuestionIdealAnswersUseCase>();
final retrieveQnaListFromChatListUseCase =
    locator<RetrieveQnaListFromChatListUseCase>();
final getRandomInterviewQuestionUseCase =
    locator<GetRandomInterviewQuestionUseCase>();
final getChatListUseCase = locator<GetChatRoomsUseCase>();
final updateChatInfoUseCase = locator<UpdateChatInfoUseCase>();
