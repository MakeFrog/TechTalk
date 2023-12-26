import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/remote/chat_remote_data_source.dart';
import 'package:techtalk/features/chat/data/remote/chat_remote_data_source_impl.dart';
import 'package:techtalk/features/chat/use_cases/create_chat_room_use_case.dart';
import 'package:techtalk/features/chat/use_cases/update_chat_messages_use_case.dart';

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
      ..registerFactory(
        () => CreateChatRoomUseCase(
          chatRepository,
        ),
      )
      ..registerFactory(
        () => GetChatRoomsUseCase(
          chatRepository,
        ),
      )
      ..registerFactory(
        () => GetChatRoomUseCase(
          chatRepository,
        ),
      )
      ..registerFactory(
        () => GetChatMessageHistoryUseCase(
          chatRepository,
        ),
      )
      ..registerFactory(
        () => GetChatQnasUseCase(
          chatRepository,
        ),
      )
      ..registerFactory(() => GetAnswerFeedbackUseCase())
      ..registerFactory(
        () => CreateChatMessagesUseCase(
          chatRepository,
        ),
      )
      ..registerFactory(() => UpdateChatMessagesUseCase(chatRepository));
  }
}
