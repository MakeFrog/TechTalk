import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';

final class CreateInterviewRoomUseCase {
  CreateInterviewRoomUseCase(this._chatRepository);

  final ChatRepository _chatRepository;
  Future<Result<String>> call({
    required String topicId,
    required int questionCount,
  }) async {
    final result = await _chatRepository.createRoom(
      topicId: topicId,
      questionCount: questionCount,
    );
    return result.fold(
      onSuccess: (value) async {
        return result;
      },
      onFailure: (e) {
        throw e;
      },
    );
  }
}
