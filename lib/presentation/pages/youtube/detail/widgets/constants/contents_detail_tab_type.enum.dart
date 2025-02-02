import 'package:techtalk/app/localization/locale_keys.g.dart';

enum ContentsDetailTabType {
  summary(LocaleKeys.youtubeDetail_summary),
  questions(LocaleKeys.youtubeDetail_interview);

  final String displayStr;

  const ContentsDetailTabType(this.displayStr);
}
