import 'package:techtalk/features/contents/repositories/entities/contents_author_entity.dart';
import 'package:techtalk/features/user/repositories/entities/user_entity.dart';
import 'package:techtalk/presentation/pages/youtube/constants/contents_detail_tab_type.enum.dart';

mixin class YoutubeContentsDetailEvent {
  tabChanged(ContentsDetailTabType tabType) {}

  onTapAuthorProfile(ContentsAuthorEntity author) {}

  onTapUploaderProfile(UserEntity uploader) {}
}
