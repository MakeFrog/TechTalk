import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/modules/exceptions/custom_exception.dart';
import 'package:techtalk/core/services/snack_bar_service.dart';
import 'package:techtalk/features/topic/repositories/entities/wrong_answer_entity.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'wrong_answers_provider.g.dart';

@Riverpod(keepAlive: true)
class WrongAnswers extends _$WrongAnswers {
  @override
  FutureOr<List<WrongAnswerEntity>> build(String topicId) async {
    final response = await getWrongAnswersUseCase(topicId);

    return response.fold(
      onSuccess: (wrongAnswers) {
        return wrongAnswers;
      },
      onFailure: (e) {
        SnackBarService.showSnackBar((e as CustomException).message);
        throw e;
      },
    );
  }
}
