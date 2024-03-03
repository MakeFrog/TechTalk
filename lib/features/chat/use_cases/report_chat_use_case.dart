import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/chat/chat.dart';

class ReportChatUseCase {
  ReportChatUseCase(this._repository);

  final ChatRepository _repository;

  Future<Result<void>> call(
    FeedbackChatEntity feedback,
    AnswerChatEntity answer,
  ) async {
    return _repository.uploadChatIssueReport(feedback, answer);
  }
}
