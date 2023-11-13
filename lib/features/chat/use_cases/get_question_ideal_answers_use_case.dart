import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';

class GetQuestionIdealAnswersUseCase
    extends BaseUseCase<InterviewQuestionEntity, Result<List<String>>> {
  GetQuestionIdealAnswersUseCase(this._repository);

  final ChatRepository _repository;

  @override
  Future<Result<List<String>>> call(InterviewQuestionEntity request) =>
      _repository.getIdealAnswers(request);
}
