import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

class GetChatRoomsUseCase
    extends BaseUseCase<Topic, Result<List<ChatRoomEntity>>> {
  GetChatRoomsUseCase(this._repository);

  final ChatRepository _repository;

  @override
  Future<Result<List<ChatRoomEntity>>> call(Topic request) {
    return _repository.getChatRoomList(request.id);
  }
}
