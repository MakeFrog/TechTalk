sealed class CustomException implements Exception {
  const CustomException(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => '$code: $message';
}

class UnAuthorizedException extends CustomException {
  const UnAuthorizedException() : super('000000', '유저 인증 정보를 불러올 수 없습니다.');
}

class AlreadyExistUserDataException extends CustomException {
  const AlreadyExistUserDataException() : super('100001', '이미 유저 데이터가 존재합니다.');
}

class NoUserDataException extends CustomException {
  const NoUserDataException() : super('100002', '유저 데이터가 존재하지않습니다.');
}

class AlreadyExistNicknameException extends CustomException {
  const AlreadyExistNicknameException() : super('100003', '중복된 닉네임입니다.');
}

class NoTopicQuestionException extends CustomException {
  const NoTopicQuestionException(String topic)
      : super('200002', '$topic 주제의 면접 질문이 없습니다.');
}

class NoTopicException extends CustomException {
  const NoTopicException(String topic)
      : super('200003', '$topic 주제 데이터가 없습니다.');
}

class NoQnAsException extends CustomException {
  const NoQnAsException(String topic)
      : super('200004', '$topic 주제의 면접 문답 데이터가 없습니다.');
}

class TopicInitialFailed extends CustomException {
  const TopicInitialFailed() : super('200005', '면접 주제 초기화 동작에 실패하였습니다.');
}

class ChatMessageFetchedFailedException extends CustomException {
  const ChatMessageFetchedFailedException()
      : super('300001', '채팅 기록을 가져오는데 실패하였습니다.');
}

class ChatRoomsFetchedFailedException extends CustomException {
  const ChatRoomsFetchedFailedException()
      : super('300002', '채팅방 목록을 가져오는데 실패하였습니다.');
}

class ChatRoomCreationFailedException extends CustomException {
  const ChatRoomCreationFailedException()
      : super('300003', '채팅방을 생성하는데 실패하였습니다.');
}

class ChatReportFailed extends CustomException {
  const ChatReportFailed() : super('300004', '면접 이슈를 리포트하는 과정에서 오류가 발생하였습니다.');
}

class NoInterviewQuestionException extends CustomException {
  const NoInterviewQuestionException(String topic)
      : super('000002', '$topic 주제의 면접 질문이 없습니다.');
}

class NoInterviewTopicException extends CustomException {
  const NoInterviewTopicException(String topic)
      : super('000003', '$topic 주제 데이터가 없습니다.');
}

class FetchSkillsFailedException extends CustomException {
  const FetchSkillsFailedException()
      : super('000004', '테크 스킬 목록을 불러오는데 실패하였습니다');
}

class WrongAnswerUpdateFailedException extends CustomException {
  const WrongAnswerUpdateFailedException()
      : super('000005', '오답노트 정보를 업데이트하는데 실패하였습니다.');
}

class WrongAnswerFetchFailedException extends CustomException {
  const WrongAnswerFetchFailedException()
      : super('000006', '오답노트 목록을 가져오는데 실패하였습니다.');
}

class ImgStoreFailedException extends CustomException {
  const ImgStoreFailedException() : super('400001', '이미지 저장에 실패하였습니다.');
}

class MappingFailedException extends CustomException {
  const MappingFailedException() : super('400002', '데이터 호출에 실패하였습니다.');
}

class VersionInfoFetchedFailedException extends CustomException {
  const VersionInfoFetchedFailedException()
      : super('500001', '앱 버전 정보를 가져오는데 실패하였습니다.');
}

class SystemNotAvailableWithNotification extends CustomException {
  const SystemNotAvailableWithNotification()
      : super('500002', '시스템 사용불가 / 공지 메세지');
}

class SystemOnMaintenanceException extends CustomException {
  const SystemOnMaintenanceException() : super('500003', '점검');
}

class SystemNeedUpdateException extends CustomException {
  const SystemNeedUpdateException() : super('500005', '업데이트 필요');
}

class SystemNetworkUnstable extends CustomException {
  const SystemNetworkUnstable() : super('500006', '네트워크 불안정');
}

class SystemSomethingWrongException extends CustomException {
  const SystemSomethingWrongException() : super('500007', '알 수 없는 오류');
}
