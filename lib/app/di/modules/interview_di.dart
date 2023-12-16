import 'package:get_it/get_it.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/features/wrong_answer_note/usecases/get_wrong_answer_qnas_use_case.dart';
import 'package:techtalk/features/wrong_answer_note/wrong_answer_note.dart';

final class InterviewDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {}

  @override
  void repositories() {}

  @override
  void useCases() {
    GetIt.I
      ..registerFactory<GetReviewNoteQuestionListUseCase>(
        () => GetReviewNoteQuestionListUseCase(
          wrongAnswerNoteRepository,
        ),
      );
  }
}
