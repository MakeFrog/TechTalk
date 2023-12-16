import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';

class GetRandomInterviewQuestionUseCase
    extends BaseUseCase<String, Result<InterviewQuestionEntity>> {
  GetRandomInterviewQuestionUseCase(this._repository);

  final ChatRepository _repository;

  @override
  Future<Result<InterviewQuestionEntity>> call(String request) async {
    return _repository.getRandomQuestion(request);
  }
}
