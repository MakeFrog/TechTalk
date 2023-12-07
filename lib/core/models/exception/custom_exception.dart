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
  const AlreadyExistUserDataException() : super('000001', '이미 유저 데이터가 존재합니다.');
}
