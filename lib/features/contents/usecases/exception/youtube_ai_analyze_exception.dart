sealed class YoutubeAiAnalyzeException implements Exception {
  const YoutubeAiAnalyzeException(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => '$code: $message';
}

class YtTimeoutException extends YoutubeAiAnalyzeException {
  const YtTimeoutException() : super('1000', '시간내에 영상을 분석하지 못하였습니다');
}

class YtJsonFormatException extends YoutubeAiAnalyzeException {
  const YtJsonFormatException() : super('1', '예상하지 못한 오류가 발생했습니다. 다시 시도해주세요');
}

class YtInvalidVideoContent extends YoutubeAiAnalyzeException {
  const YtInvalidVideoContent() : super('2', '분석 가능한 영상이 아님');
}

class YtToManyTokenRequired extends YoutubeAiAnalyzeException {
  const YtToManyTokenRequired() : super('3', '영상 길이가 너무 길음');
}

class YtUnknownException extends YoutubeAiAnalyzeException {
  const YtUnknownException() : super('5', '예상하지 못한 오류가 발생했습니다. 다시 시도해주세요');
}

class YtUnexceptedGptException extends YoutubeAiAnalyzeException {
  const YtUnexceptedGptException()
      : super('6', '예상하지 못한 오류가 발생했습니다. 다시 시도해주세요');
}
