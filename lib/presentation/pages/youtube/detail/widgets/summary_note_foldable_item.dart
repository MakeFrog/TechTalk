import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/app/util/app_formatter.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/widgets/common/box/filled_text_box.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

/// 요약 노트 아이템 위젯
class SummaryNoteFoldableItem extends HookWidget {
  const SummaryNoteFoldableItem({
    Key? key,
    required this.timestamp,
    required this.title,
    required this.contents,
    required this.isActivated,
    required this.seeAllNotifier,
    this.onTapTimestamp,
    this.isLoaded = true,
  }) : super(key: key);

  final Duration? timestamp;
  final String title;
  final List<String> contents;
  final bool isActivated;
  final ValueNotifier<int> seeAllNotifier;
  final void Function(Duration?)? onTapTimestamp;
  final bool isLoaded;

  factory SummaryNoteFoldableItem.loading() {
    return SummaryNoteFoldableItem(
      timestamp: null,
      title: '',
      contents: [],
      isLoaded: false,
      isActivated: false,
      seeAllNotifier: ValueNotifier(0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    useEffect(() {
      if (!isLoaded) return;

      /// '전체 보기' 실행여부를 listen하여
      /// expand 값을 조절
      if (!isExpanded.value && seeAllNotifier.value != 0) {
        isExpanded.value = true;
      }
    }, [seeAllNotifier.value]);

    return IgnorePointer(
      ignoring: !isLoaded,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FlexibleExpansionTile(
              highlightColor: Colors.transparent,
              isExpanded: isExpanded,
              curve: Curves.fastOutSlowIn,
              reverseCurve: Curves.fastOutSlowIn,
              reverseDuration: const Duration(milliseconds: 300),
              gapBetweenTitleAndContent: 8,
              alignment: Alignment.centerLeft,
              title: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // crossAxisAlignment: WrapCrossAlignment.center,
                  // runSpacing: 6,
                  children: [
                    GestureDetector(
                      onTap: () => onTapTimestamp?.call(timestamp),
                      child: Container(
                        height: 28,
                        width: 54,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isActivated
                              ? const Color(0xFFFFF9E0)
                              : AppColor.of.background1,
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                        child: Text(
                          AppFormatter.formatDurationToHHmm(
                            timestamp ?? Duration.zero,
                          ),
                          style: isActivated
                              ? AppTextStyle.body1.copyWith(
                                  color: const Color(0xFFFFB520),
                                )
                              : AppTextStyle.body2.copyWith(
                                  color: AppColor.of.gray3,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: AppSize.screenWidth - 32 - 56 - 8,
                      constraints: const BoxConstraints(
                        minHeight: 24,
                      ),
                      alignment: Alignment.centerLeft,
                      child: isLoaded
                          ? Text(
                              title,
                              style: isActivated
                                  ? AppTextStyle.title3
                                  : AppTextStyle.body2,
                              textAlign: TextAlign.start,
                            )
                          : const SkeletonBox(
                              width: 120,
                              padding: EdgeInsets.symmetric(vertical: 2),
                              height: 20,
                            ),
                    ),
                  ],
                ),
              ),
              content: FilledTextBox(
                contents: contents,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
