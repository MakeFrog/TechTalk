import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';

class GetChatListUseCase
    extends BaseUseCase<InterviewTopic, Result<List<ChatRoomListItemEntity>>> {
  GetChatListUseCase(this._repository);

  final ChatRepository _repository;

  @override
  Future<Result<List<ChatRoomListItemEntity>>> call(InterviewTopic request) {
    return _repository.getChatRoomList(request.id);
  }
}
