import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/entities/topic_entity.dart';

class GetChatMessagesUseCase
    extends BaseUseCase<GetChatListParam, Result<List<MessageEntity>>> {
  GetChatMessagesUseCase(this._repository);

  final ChatRepository _repository;

  @override
  Future<Result<List<MessageEntity>>> call(GetChatListParam request) async {
    if (request.progressState.isInitial) {
      final String initialMessage =
          '반가워요! ${request.userName}님. ${request.topic.name} 면접 질문을 드리겠습니다';

      final initialChats = [
        GuideMessageEntity.createStream(
          initialMessage.convertToStreamText,
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
  TopicEntity topic
});
