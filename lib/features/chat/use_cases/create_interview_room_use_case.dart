import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/user/user.dart';

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
        final userData = await getUserDataUseCase();
        await _chatRepository.updateMessages(
          value,
          messages: [
            GuideMessageEntity.createStatic(
              message:
                  '반가워요! ${userData!.nickname}님. ${Topic.getTopicById(topicId).text} 면접 질문을 드리겠습니다',
              timestamp: DateTime.now(),
            ),
          ],
        );
        return result;
      },
      onFailure: (e) {
        throw e;
      },
    );
  }
}
