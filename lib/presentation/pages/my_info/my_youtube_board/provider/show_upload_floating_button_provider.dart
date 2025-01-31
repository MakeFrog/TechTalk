import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/presentation/pages/my_info/my_youtube_board/provider/uploaded_history_paging_controller_provider.dart';

part 'show_upload_floating_button_provider.g.dart';

///
/// - [uploadedHistoryPagingControllerProvider]를 watch하여,
///   아이템 개수에 따라 `true`/`false`를 결정합니다.
///
@riverpod
class ShowUploadFloatingButton extends _$ShowUploadFloatingButton {
  @override
  bool build() {
    final pagingController = ref.watch(uploadedHistoryPagingControllerProvider);

    pagingController.addListener(() {
      state = (pagingController.itemList?.length ?? 0) > 0;
    });

    final itemCount = pagingController.itemList?.length ?? 0;

    return itemCount > 0;
  }
}
