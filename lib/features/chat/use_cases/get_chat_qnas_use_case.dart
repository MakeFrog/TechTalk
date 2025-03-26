import 'package:techtalk/app/util/app_logger.dart';
import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/chat/chat.dart';

final class GetChatQnasUseCase {
  GetChatQnasUseCase(this._chatRepository);

  final ChatRepository _chatRepository;

  Future<Result<List<ChatQnaEntity>>> call(ChatRoomEntity room) async {
    return room.type.typedBranch(
      common: (_) => _chatRepository.getCommonChatQnas(room),
      resume: (_) => _chatRepository.getResumeChatQnas(room),
      youtube: (_) {
        logger.e('유튜브 면접을 채팅 기록을 반환하지 않음');
        return Result.success([]);
      },
      proficiency: (_) {
        logger.e('역량별 면접을 채팅 기록을 반환하지 않음');
        return Result.success([]);
      },
    );
  }
}
