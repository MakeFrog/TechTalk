import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/use_cases/get_interview_qna_list_use_case.dart';

final class ChatDependencyInject extends FeatureDependencyInjection {
  @override
  void dataSources() {}

  @override
  void repositories() {
    locator.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl());
  }

  @override
  void useCases() {
    locator.registerFactory(() => GetChatListUseCase(chatRepository));
    locator.registerFactory(() => GetInterviewQnaListUseCase(chatRepository));
    locator.registerFactory(() => GetAnswerFeedbackUseCase());
  }
}
