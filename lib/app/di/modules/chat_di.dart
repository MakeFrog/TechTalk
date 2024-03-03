import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data_source/remote/chat_remote_data_source.dart';
import 'package:techtalk/features/chat/data_source/remote/chat_remote_data_source_impl.dart';
import 'package:techtalk/features/chat/use_cases/create_chat_room_use_case.dart';
import 'package:techtalk/features/chat/use_cases/get_chat_rooms_use_case.dart';
import 'package:techtalk/features/chat/use_cases/get_random_qnas_use_case.dart';
import 'package:techtalk/features/topic/topic.dart';

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
        () => GetChatMessageHistoryUseCase(
          chatRepository,
        ),
      )
      ..registerFactory(
        () => GetChatQnasUseCase(
          chatRepository,
        ),
      )
      ..registerFactory(() => SetAiFeedbackUseCase())
      ..registerFactory(
        () => CreateChatMessagesUseCase(
          chatRepository,
        ),
      )
      ..registerFactory(
        () => ReportChatUseCase(
          chatRepository,
        ),
      )
      ..registerFactory(
        () => GetRandomQnasUseCase(
          topicRepository,
        ),
      );
  }
}
