import 'package:techtalk/app/localization/locale_keys.g.dart';

enum YoutubeUploadFailedType {
  timeout('0', LocaleKeys.youtubeUploadFailed_timeout_title,
      LocaleKeys.youtubeUploadFailed_timeout_description),
  jsonFormatError('1', LocaleKeys.youtubeUploadFailed_jsonFormatError_title,
      LocaleKeys.youtubeUploadFailed_jsonFormatError_description),
  invalidVideoContent(
      '2',
      LocaleKeys.youtubeUploadFailed_invalidVideoContent_title,
      LocaleKeys.youtubeUploadFailed_invalidVideoContent_description),
  tooManyTokensRequired(
      '3',
      LocaleKeys.youtubeUploadFailed_tooManyTokensRequired_title,
      LocaleKeys.youtubeUploadFailed_tooManyTokensRequired_description),
  unknownError('4', LocaleKeys.youtubeUploadFailed_unknownError_title,
      LocaleKeys.youtubeUploadFailed_unknownError_description),
  unexpectedGptError(
      '5',
      LocaleKeys.youtubeUploadFailed_unexpectedGptError_title,
      LocaleKeys.youtubeUploadFailed_unexpectedGptError_description),
  isNotTechContent('6', LocaleKeys.youtubeUploadFailed_isNotTechContent_title,
      LocaleKeys.youtubeUploadFailed_isNotTechContent_description),
  noCaption('7', LocaleKeys.youtubeUploadFailed_noCaption_title,
      LocaleKeys.youtubeUploadFailed_noCaption_description),
  youtubeVideoFetchedFailed(
      '8',
      LocaleKeys.youtubeUploadFailed_youtubeVideoFetchedFailed_title,
      LocaleKeys.youtubeUploadFailed_youtubeVideoFetchedFailed_description),
  tooShortVideo('9', LocaleKeys.youtubeUploadFailed_tooShortVideo_title,
      LocaleKeys.youtubeUploadFailed_tooShortVideo_description),
  alreadyUploaded('10', LocaleKeys.youtubeUploadFailed_alreadyUploaded_title,
      LocaleKeys.youtubeUploadFailed_alreadyUploaded_description);

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
