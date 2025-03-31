import 'package:techtalk/features/youtube/index.dart';

///
/// AI 프롬프트 로직에서 발생하는 Exception 정의
/// 추후 [YoutubeUploadException]과 통합하는것도 고려 필요
///
sealed class AiCreationFailedException implements Exception {
  const AiCreationFailedException(this.code, this.message);

  final String code;
  final String message;
  @override
  String toString() => '$code: $message';
}

class AiTimeoutException extends AiCreationFailedException {
  const AiTimeoutException() : super('0', '시간내에 생성은 완료하지 못했어요');
}

/// 잘못된 형태로 응답이 내려옴
/// 극한의 경우 잘못된 json 형태로 내려오는 경우가 있음.
class AiJsonFormatException extends AiCreationFailedException {
  const AiJsonFormatException() : super('1', '예상하지 못한 오류가 발생했습니다. 다시 시도해주세요');
}

/// 예상하지 못한 정의가 안된 오류
class AiUnExpectedException extends AiCreationFailedException {
  const AiUnExpectedException() : super('400', '예상하지 못한 오류가 발생했습니다. 다시 시도해주세요');
}
