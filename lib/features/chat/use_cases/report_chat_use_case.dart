import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';

class ReportChatUseCase {
  ReportChatUseCase(this._repository);

  final ChatRepository _repository;

  Future<Result<void>> call(
    FeedbackChatMessageEntity feedback,
    AnswerChatMessageEntity answer,
  ) async {
    return _repository.reportFeedback(feedback, answer);
  }
}
