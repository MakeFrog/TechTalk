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

class ImgStoreFailedException extends CustomException {
  const ImgStoreFailedException() : super('400001', '이미지 저장에 실패하였습니다.');
}

class MappingFailedException extends CustomException {
  const MappingFailedException() : super('400002', '데이터 호출에 실패하였습니다.');
}
