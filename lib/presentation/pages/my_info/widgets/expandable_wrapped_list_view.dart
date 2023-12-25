import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/helper/bool_extension.dart';
import 'package:techtalk/core/helper/hook_helper.dart';
import 'package:techtalk/presentation/pages/my_info/my_page_widget_event.dart';
import 'package:techtalk/presentation/widgets/common/chip/rounded_filled_chip.dart';

///
/// 전달받은 데이터를 기반으로 Wrap 위젯이 단일 행으로 구성되어 있는지 판별하여 (check if it's overflowed),
/// Expandable 로직을 적용하는 위젯
///

class ExpandableWrappedListview extends HookWidget with MyPageWidgetEvent {
  // ExpandableWrappedListview({Key? key, required List<String> items})  : super(key: key, aim = 0));

  ExpandableWrappedListview({super.key, required List<String> items})
      : itemCollection = items.map((e) => (text: e, key: GlobalKey())).toList();

  /// 현재 위젯의 notifier 변수
  final ValueNotifier<Size> notifier = ValueNotifier(const Size(0, 0));

  /// [Wrap] 위젯의 고정 값들
  final double rowHeight = 48;
  final double spacing = 8;
  final double runSpacing = 12;

  /// 전달 받은 데이터를 globalKey값과 매핑
  final List<({String text, GlobalKey key})> itemCollection;

  @override
  Widget build(BuildContext context) {
    /// list item이 overflow 되었는지 여부
    final isOverflowed = useState(false);

    /// [Wrap]의 본래 높이
    final originHeight = useState(0.0);

    /// 첫 번째 행의 끝 위치
    final firstRowElementY = useState(0.0);

    /// 마지막 행의 끝 위치
    final lastRowElementY = useState(0.0);

    ///
    /// 위젯이 렌더링되고 최초 1번 실행되는 이벤트
    /// 1) [Wrap] 위젯의 본 사이즈 계싼
    /// 2) [Wrap] 위젯의 자식 위젯들의 포지션 계산

    usePostFrameEffect(() {
      getWrapWidgetSize(context, notifier, originHeight);
      if (notifier.value.height < rowHeight) return;
      isOverflowed.value = true;
      getListItemPosition(
          itemCollection, firstRowElementY, lastRowElementY, spacing);
    }, []);

    return DeferredPointerHandler(
      child: Container(
        margin: const EdgeInsets.only(right: 50),
        child: ValueListenableBuilder(
          valueListenable: notifier,
          builder: (context, size, _) {
            if (isOverflowed.value.isTrue) {
              /// Expandable한 Wrap 위젯
              return HookBuilder(
                builder: (context) {
                  final isExpanded = useState(false);
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      AnimatedContainer(
                        height: !isExpanded.value ? 36 : originHeight.value,
                        duration: const Duration(milliseconds: 200),
                        child: Wrap(
                          spacing: spacing,
                          runSpacing: runSpacing,
                          clipBehavior: Clip.hardEdge,
                          children: [
                            ...List.generate(
                              itemCollection.length,
                              (index) {
                                return RoundedFilledChip(
                                  text: itemCollection[index].text,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      if (isOverflowed.value.isTrue)
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          left: isExpanded.value
                              ? lastRowElementY.value
                              : firstRowElementY.value,
                          bottom: 6,
                          child: DeferPointer(
                            paintOnTop: true,
                            child: GestureDetector(
                                onTap: () {
                                  isExpanded.value = !isExpanded.value;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: SvgPicture.asset(isExpanded.value
                                      ? Assets.iconsRoundedTop
                                      : Assets.iconsRoundedMore),
                                )),
                          ),
                        )
                    ],
                  );
                },
              );
            } else {
              return _buildOriginWrappedView();
            }
          },
        ),
      ),
    );
  }

  /// expandable 로직이 적용되어 있지 않은 기본 Wrap 위젯
  Widget _buildOriginWrappedView() => Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        clipBehavior: Clip.hardEdge,
        children: [
          ...List.generate(
            itemCollection.length,
            (index) {
              return RoundedFilledChip(
                text: itemCollection[index].text,
                key: itemCollection[index].key,
              );
            },
          )
        ],
      );
}
