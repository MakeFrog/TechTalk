part of '../my_youtube_board_page.dart';

///
/// 삭제 애니메이션 적용되는 리스트 아이템 위젯
/// 나중에 common하게 만들면 좋을 것 같음.
///
class _BookmarkAnimatedDeletableListItem extends StatefulWidget {
  final YoutubeMainEntity item;
  final VoidCallback onConfirmDelete; // 실제로 목록에서 제거하는 콜백

  const _BookmarkAnimatedDeletableListItem({
    Key? key,
    required this.item,
    required this.onConfirmDelete,
  }) : super(key: key);

  @override
  State<_BookmarkAnimatedDeletableListItem> createState() =>
      _BookmarkAnimatedDeletableListItemState();
}

class _BookmarkAnimatedDeletableListItemState
    extends State<_BookmarkAnimatedDeletableListItem>
    with SingleTickerProviderStateMixin {
  bool _isDeleted = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      // 애니메이션 지속 시간
      duration: const Duration(milliseconds: 250),
      // 애니메이션 곡선 (원하는 다른 Curves로 변경 가능)
      curve: Curves.easeInOut,
      // '위쪽을 기준으로' 높이가 줄어듦 → 아래에서 위로 접히는 듯한 효과
      alignment: Alignment.topCenter,

      // child가 SizedBox()로 바뀌면 height가 0이 되어 애니메이션으로 접힘
      child: _isDeleted
          ? const SizedBox()
          : Container(
              key: ValueKey(widget.item.id),
              margin: const EdgeInsets.only(bottom: 16),
              child: YoutubeContentSmallItemView(
                onTapDeleteButton: _onDeleteTap,
                thumbnailImgUrl: widget.item.thumbnailImgUrl,
                title: widget.item.contentsTitle,
                channelName: widget.item.channel.name,
                videoDuration: widget.item.videoDuration,
                questionCount: widget.item.qnaNum,
                videoId: widget.item.id,
              ),
            ),
    );
  }

  Future<void> _onDeleteTap() async {
    // 1) 우선 _isDeleted = true 로 만들어서,
    //    AnimatedSize가 child의 크기를 0으로 서서히 줄이는 애니메이션 실행
    setState(() => _isDeleted = true);

    // 2) 애니메이션 시간만큼 대기
    await Future.delayed(const Duration(milliseconds: 250));

    // 3) 실질적으로 PagingController.itemList에서 제거
    widget.onConfirmDelete();
  }
}
