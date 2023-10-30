import 'package:get_it/get_it.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/features/chat/chat.dart';

final class ChatDependencyInject extends FeatureDependencyInjection {
  @override
  void dataSources() {}

  @override
  void repositories() {
    GetIt.I.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl());
  }

  @override
  void useCases() {
    GetIt.I.registerFactory(() => GetChatListUseCase(chatRepository));
    GetIt.I.registerFactory(() => GetAnswerFeedbackUseCase());
  }
}
