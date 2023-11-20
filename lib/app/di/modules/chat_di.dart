import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/remote/chat_remote_data_source.dart';
import 'package:techtalk/features/chat/data/remote/chat_remote_data_source_impl.dart';

final class ChatDependencyInject extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator.registerLazySingleton<ChatRemoteDataSource>(
        () => ChatRemoteDataSourceImpl());
  }

  @override
  void repositories() {
    locator.registerLazySingleton<ChatRepository>(
        () => ChatRepositoryImpl(chatRemoteDataSource));
  }

  @override
  void useCases() {
    locator
      ..registerFactory(() => RetrieveQnaListFromChatListUseCase())
      ..registerFactory(() => GetChatMessagesUseCase(chatRepository))
      ..registerFactory(() => GetQuestionIdealAnswersUseCase(chatRepository))
      ..registerFactory(() => GetAnswerFeedbackUseCase())
      ..registerFactory(() => GetRandomInterviewQuestionUseCase(chatRepository))
      ..registerFactory(() => GetChatListUseCase(chatRepository));
  }
}
