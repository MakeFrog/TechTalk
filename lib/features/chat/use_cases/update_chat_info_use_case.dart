import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_qna_progress_info_entity.dart';
import 'package:techtalk/features/shared/enums/interviewer_avatar.dart';
import 'package:techtalk/features/topic/topic.dart';

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
    if (request.answerState.isInitial) {
      final initialRoomInfo = ChatRoomEntity(
        interviewerInfo: request.interviewer!,
        topic: request.topic,
        chatRoomId: request.chatRoomId,
        lastChatDate: DateTime.now(),
        lastChatMessage: request.messages.first.message.value,
        qnaProgressInfo: request.qnaProgressInfo!,
      );
      return Future.wait([
        _repository.setBasicChatRoomInfo(initialRoomInfo),
        chatRepository.updateChatMessage(
          chatRoomId: request.chatRoomId,
          messages: request.messages,
        )
      ]);
    } else {
      print('에임 2');
      return Future.wait([
        _repository.updateChatRoomAnswerCount(
          chatRoomId: request.chatRoomId,
          answerState: request.answerState,
        ),
        _repository.updateChatMessage(
          chatRoomId: request.chatRoomId,
          messages: request.messages,
        ),
      ]);
    }
  }
}

typedef UpdateChatInfoParam = ({
  List<MessageEntity> messages,
  String chatRoomId,
  AnswerState answerState,
  Topic topic,
  ChatQnaProgressInfoEntity? qnaProgressInfo,
  InterviewerAvatar? interviewer,
});
