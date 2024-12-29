import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:techtalk/core/helper/duration_extension.dart';

/// 요약 노트 아이템 위젯
class SummaryNoteFoldableItem extends HookWidget {
  const SummaryNoteFoldableItem({
    Key? key,
    required this.timestamp,
    required this.title,
    required this.contents,
    this.onTapTimestamp,
    this.height = 35,
  }) : super(key: key);

  final Duration? timestamp;
  final String title;
  final List<String> contents;
  final void Function(Duration?)? onTapTimestamp;
  final double height;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);

    return InkWell(
      onTap: () {
        isExpanded.value = !isExpanded.value;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 타임스탬프와 타이틀 영역
          Container(
            height: height,
            color: Colors.grey,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => onTapTimestamp?.call(timestamp),
                  child: Container(
                    height: height,
                    color: Colors.blueGrey,
                    alignment: Alignment.center,
                    child: Text(
                      timestamp?.formatTimestamp ?? '',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                ),
              ],
            ),
          ),

          // 애니메이션을 적용한 내용 표시
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            child: ConstrainedBox(
              constraints: isExpanded.value
                  ? const BoxConstraints()
                  : const BoxConstraints(maxHeight: 0),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    ...contents.map((e) => Text(e)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
