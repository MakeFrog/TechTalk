import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/entities/guide_chat_entity.dart';
import 'package:techtalk/features/chat/enums/interview_progress_state.enum.dart';
import 'package:techtalk/features/chat/enums/interview_topic.enum.dart';

class GetChatListUseCase
    extends BaseUseCase<GetChatListParam, Result<List<ChatEntity>>> {
  GetChatListUseCase(this._repository);

  final ChatRepository _repository;

  @override
  Future<Result<List<ChatEntity>>> call(GetChatListParam request) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (request.progressState.isInitial) {
      final String initialMessage =
          '반가워요! ${request.userName}님. ${request.topic.text} 면접 질문을 드리겠습니다';

      final initialChats = [
        GuideChatEntity.createStatic(
          initialMessage,
        ),
      ];

      return Future.value(Result.success(initialChats));
    } else {
      return _repository.getChatList(request.roomId!);
    }
  }
}

typedef GetChatListParam = ({
  InterviewProgressState progressState,
  String? userName,
  String? roomId,
  InterviewTopic topic
});
