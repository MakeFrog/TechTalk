import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/entities/chat_entity.dart';

abstract interface class ChatRepository {
  /// 채팅 리스트 데이터 호출
  Future<Result<List<ChatEntity>>> getChatList(String roomId);
}
