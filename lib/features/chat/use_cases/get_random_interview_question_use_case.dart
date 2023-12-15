import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

class GetRandomInterviewQuestionUseCase
    extends BaseUseCase<Topic, Result<InterviewQuestionEntity>> {
  GetRandomInterviewQuestionUseCase(this._repository);

  final ChatRepository _repository;

  @override
  Future<Result<InterviewQuestionEntity>> call(Topic request) async {
    return _repository.getRandomQuestion(request.id);
  }
}
