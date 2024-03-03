import 'dart:async';

import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

final class UpdateWrongAnswerUseCase
    extends BaseUseCase<ChatQnaEntity, Result<void>> {
  UpdateWrongAnswerUseCase(this._repository);

  final TopicRepository _repository;

  @override
  FutureOr<Result<void>> call(ChatQnaEntity request) =>
      _repository.updateWrongAnswer(request);
}
