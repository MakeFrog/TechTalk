import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/chat/repositories/chat_repository.dart';
import 'package:techtalk/features/chat/use_cases/get_answer_feedback_use_case.dart';
import 'package:techtalk/features/chat/use_cases/get_chat_list_use_case.dart';
import 'package:techtalk/features/chat/use_cases/get_interview_qna_list_use_case.dart';

export 'chat.dart';
export 'entities/chat_entity.dart';
export 'entities/received_chat_entity.dart';
export 'entities/sent_chat_entity.dart';
export 'enums/answer_state.enum.dart';
export 'enums/chat_type.enum.dart';
export 'repositories/chat_repository.dart';
export 'repositories/chat_repository_impl.dart';
export 'use_cases/get_answer_feedback_use_case.dart';
export 'use_cases/get_chat_list_use_case.dart';

final chatRepository = locator<ChatRepository>();
final getChatListUseCase = locator<GetChatListUseCase>();
final getAnswerFeedBackUseCase = locator<GetAnswerFeedbackUseCase>();
final getInterviewQnaListUseCase = locator<GetInterviewQnaListUseCase>();
