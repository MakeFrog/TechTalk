import 'package:techtalk/app/localization/locale_keys.g.dart';

enum YoutubeBoardTabType {
  watchHistory(LocaleKeys.myInfo_watchHistory),
  bookmark(LocaleKeys.myInfo_favorites),
  uploaded(LocaleKeys.myInfo_uploadedVideos);

  final String label;

  const YoutubeBoardTabType(this.label);
}
