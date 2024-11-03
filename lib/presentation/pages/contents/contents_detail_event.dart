import 'package:techtalk/features/contents/repositories/entities/contents_author_entity.dart';
import 'package:techtalk/features/user/repositories/entities/user_entity.dart';
import 'package:techtalk/presentation/pages/contents/contents_detail_page.dart';

mixin class ContentsDetailEvent {
  tabChanged(TabType tabType) {}

  onTapAuthorProfile(ContentsAuthorEntity author) {}

  onTapUploaderProfile(UserEntity uploader) {}
}
