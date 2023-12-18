import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/features/chat/chat.dart';

///
/// 채팅 정보 업데이트
///
/// 진행중인 면접일 떄
/// - 정답 or 오답 개수 업데이트 +1
/// - 채팅 메세지 리스트 업데이트
///
/// 처음으로 면접에 들어왔을 때
/// - 기본 채팅방 정보 업데이트
///

class UpdateChatInfoUseCase extends BaseUseCase<UpdateChatInfoParam, void> {
  UpdateChatInfoUseCase(this._repository);

  final ChatRepository _repository;

  @override
  Future<void> call(UpdateChatInfoParam request) {
    return _repository.updateMessages(
      request.chatRoomId,
      messages: request.messages,
    );
  }
}

typedef UpdateChatInfoParam = ({
  List<MessageEntity> messages,
  String chatRoomId,
});
