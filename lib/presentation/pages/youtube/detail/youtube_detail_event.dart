import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/user/repositories/entities/user_entity.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/is_bookmark_checked_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/widgets/constants/contents_detail_tab_type.enum.dart';

mixin class YoutubeDetailEvent {
  ///
  /// 북마크 버튼이 탭 되었을 때
  ///
  void onBookmarkBtnTapped(WidgetRef ref) {
    ref.read(isBookmarkCheckedProvider.notifier).toggle();
  }

  tabChanged(ContentsDetailTabType tabType) {}

  onTapAuthorProfile(ChannelEntity author) {}

  onTapUploaderProfile(UserEntity uploader) {}
}
