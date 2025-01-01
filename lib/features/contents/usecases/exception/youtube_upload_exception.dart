sealed class YoutubeUploadException implements Exception {
  const YoutubeUploadException(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => '$code: $message';
}

class YtTimeoutException extends YoutubeUploadException {
  const YtTimeoutException() : super('0', '시간내에 영상을 분석하지 못하였습니다');
}

class YtJsonFormatException extends YoutubeUploadException {
  const YtJsonFormatException() : super('1', '예상하지 못한 오류가 발생했습니다. 다시 시도해주세요');
}

class YtInvalidVideoContentException extends YoutubeUploadException {
  const YtInvalidVideoContentException() : super('2', '분석 가능한 영상이 아님');
}

class YtToManyTokenRequiredException extends YoutubeUploadException {
  const YtToManyTokenRequiredException() : super('3', '영상 길이가 너무 길음');
}

class YtUnknownException extends YoutubeUploadException {
  const YtUnknownException() : super('4', '예상하지 못한 오류가 발생했습니다. 다시 시도해주세요');
}

class YtUnexceptedGptException extends YoutubeUploadException {
  const YtUnexceptedGptException()
      : super('5', '예상하지 못한 오류가 발생했습니다. 다시 시도해주세요');
}

class YtIsNotTechContentException extends YoutubeUploadException {
  const YtIsNotTechContentException() : super('6', '개발 영상이 아님');
}

class YtNoCaptionException extends YoutubeUploadException {
  const YtNoCaptionException() : super('7', '자막이 없는 영상');
}

class YtVideoInfoFetchedFailedException extends YoutubeUploadException {
  const YtVideoInfoFetchedFailedException() : super('8', '유튜브 콘텐츠 정보 fetch 실패');
}

class YtNotEnoughContentDurationException extends YoutubeUploadException {
  const YtNotEnoughContentDurationException() : super('9', '영상 길이가 짧음 (쇼츠)');
}

class YtAlreadyUploadedException extends YoutubeUploadException {
  final String contentId;
  const YtAlreadyUploadedException(this.contentId)
      : super('10', '이미 테크톡에 업로드된 영상');
}
