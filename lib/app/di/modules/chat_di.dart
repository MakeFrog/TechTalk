import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/use_cases/get_question_ideal_answers_use_case.dart';
import 'package:techtalk/features/chat/use_cases/get_random_interview_question_use_case.dart';
import 'package:techtalk/features/chat/use_cases/retrieve_qna_list_from_chat_list_use_case.dart';

final class ChatDependencyInject extends FeatureDependencyInjection {
  @override
  void dataSources() {}

  @override
  void repositories() {
    locator.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl());
  }

  @override
  void useCases() {
    locator.registerFactory(() => RetrieveQnaListFromChatListUseCase());
    locator.registerFactory(() => GetChatListUseCase(chatRepository));
    // locator.registerFactory(() => GetInterviewQnaListUseCase(chatRepository));
    locator
        .registerFactory(() => GetQuestionIdealAnswersUseCase(chatRepository));
    locator.registerFactory(() => GetAnswerFeedbackUseCase());
    locator.registerFactory(
        () => GetRandomInterviewQuestionUseCase(chatRepository));
  }
}
