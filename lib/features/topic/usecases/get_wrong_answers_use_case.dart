import 'dart:async';

import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/topic/topic.dart';

final class GetWrongAnswersUseCase
    extends BaseUseCase<String, Result<List<WrongAnswerEntity>>> {
  GetWrongAnswersUseCase(this._repository);

  final TopicRepository _repository;

  @override
  FutureOr<Result<List<WrongAnswerEntity>>> call(String request) =>
      _repository.getWrongAnswers(request);
}
