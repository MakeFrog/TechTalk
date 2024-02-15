import 'dart:async';

import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/repositories/topic_repository.dart';

final class UpdateWrongAnswerUseCase
    extends BaseUseCase<ChatQnaEntity, Result<void>> {
  UpdateWrongAnswerUseCase(this._repository);

  final TopicRepository _repository;

  @override
  FutureOr<Result<void>> call(ChatQnaEntity request) =>
      _repository.updateWrongAnswer(request);
}
