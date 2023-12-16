import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/wrong_answer_note/data/remote/wrong_answer_note_remote_data_source_impl.dart';
import 'package:techtalk/features/wrong_answer_note/repositories/wrong_answer_note_repository_impl.dart';
import 'package:techtalk/features/wrong_answer_note/usecases/get_wrong_answer_qnas_use_case.dart';
import 'package:techtalk/features/wrong_answer_note/wrong_answer_note.dart';

final class WrongAnswerNoteDependencyInjection
    extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator.registerFactory<WrongAnswerNoteRemoteDataSource>(
      WrongAnswerNoteRemoteDataSourceImpl.new,
    );
  }

  @override
  void repositories() {
    locator.registerLazySingleton<WrongAnswerNoteRepository>(
      () => WrongAnswerNoteRepositoryImpl(
        remoteDataSource: wrongAnswerNoteRemoteDataSource,
      ),
    );
  }

  @override
  void useCases() {
    locator
      ..registerFactory<GetWrongAnswerQnAUseCase>(
        () => GetWrongAnswerQnAUseCase(
          wrongAnswerNoteRepository,
        ),
      )
      ..registerFactory<GetWrongAnswerNoteQuestionsUseCase>(
        () => GetWrongAnswerNoteQuestionsUseCase(
          wrongAnswerNoteRepository,
        ),
      );
  }
}
