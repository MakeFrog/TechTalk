import 'package:techtalk/features/user/repositories/entities/user_entity.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/youtube/detail/widgets/constants/contents_detail_tab_type.enum.dart';

mixin class YoutubeContentsDetailEvent {
  tabChanged(ContentsDetailTabType tabType) {}

  onTapAuthorProfile(ChannelEntity author) {}

  onTapUploaderProfile(UserEntity uploader) {}
}
