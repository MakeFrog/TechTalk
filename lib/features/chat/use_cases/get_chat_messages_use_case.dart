import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';

class GetChatMessagesUseCase
    extends BaseUseCase<GetChatListParam, Result<List<MessageEntity>>> {
  GetChatMessagesUseCase(this._repository);

  final ChatRepository _repository;

  @override
  Future<Result<List<MessageEntity>>> call(GetChatListParam request) async {
    if (request.progressState.isInitial) {
      final String initialMessage =
          '반가워요! ${request.userName}님. ${request.topic.text} 면접 질문을 드리겠습니다';

      final initialChats = [
        GuideMessageEntity.createStatic(
          initialMessage,
        ),
      ];

      return Future.value(Result.success(initialChats));
    } else {
      return _repository.getChatHistory(request.roomId!);
    }
  }
}

typedef GetChatListParam = ({
  InterviewProgressState progressState,
  String? userName,
  String? roomId,
  InterviewTopic topic
});