enum YoutubeUploadFailedType {
  timeout('0', '시간안에 영상을 분석하지 못했어요', '영상의 길이나 네트워크 상태를 확인해주세요'),
  jsonFormatError('1', '일시적인 오류가 발생했습니다', '다시 업로드를 시도해주세요'),
  invalidVideoContent(
      '2', '분석할 내용이 부족해요', '충분한 면접 질문과 요약 내용을 제공할 수 있는 영상을 업로드 해주세요'),
  tooManyTokensRequired('3', '영상이 너무 길어요', '1시간 이내의 영상이 권장됩니다'),
  unknownError('4', '예상하지 못한 오류가 발생했습니다', '다시 업로드를 시도해주세요'),
  unexpectedGptError('5', '일시적인 오류가 발생했습니다', '다시 업로드를 시도해주세요'),
  isNotTechContent('6', '개발 관련 콘텐츠가 아닌 것 같아요', '개발 관련 영상을 업로드해 주세요'),
  noCaption('7', '자막이 없어 분석이 어려워요', '자막이 포함된 영상을 업로드해 주세요'),
  youtubeVideoFetchedFailed('8', '영상 정보를 가져오는데 실패했어요', '다시 업로드를 시도해 주세요'),
  tooShortVideo('9', '영상 길이가 짧아요', '1분을 초과하는 영상을 업로드해 주세요'),
  alreadyUploaded('10', '이 영상은 이미 업로드되었어요', '해당 영상으로 바로 이동할 수 있습니다');

  final String code;
  final String title;
  final String description;

  static YoutubeUploadFailedType getByErrorCode(String errorCode) {
    return values.firstWhere((e) => e.code == errorCode,
        orElse: () => YoutubeUploadFailedType.unknownError);
  }

  const YoutubeUploadFailedType(this.code, this.title, this.description);

  bool get isAlreadyUploaded => this == YoutubeUploadFailedType.alreadyUploaded;
}
