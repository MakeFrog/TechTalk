import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/helper/bool_extension.dart';
import 'package:techtalk/presentation/widgets/common/chip/rounded_filled_chip.dart';

class ExpandableWrappedListview extends HookConsumerWidget {
  ExpandableWrappedListview({Key? key}) : super(key: key);

  final ValueNotifier<Size> notifier = ValueNotifier(const Size(0, 0));

  // final Widget Function(BuildContext context, Size size, Widget? child) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double rowHeight = 36;
    final isOverflowed = useState(false);
    final isExpanded = useState(false);
    final originHeight = useState(0.0);
    final isRendered = useState(false);
    final List<String> names = [
      '서버 백엔드 개발자',
      '크래스 플랫폼 개발자',
      'iOS 개발자',
      '안드로이드 개발자',
      '닷넷 개발자',
    ];

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            notifier.value = (context.findRenderObject() as RenderBox).size;
            originHeight.value = notifier.value.height;
            isOverflowed.value = notifier.value.height > rowHeight;
            isRendered.value = true;
          },
        );
      },
      [],
    );

    return DeferredPointerHandler(
      child: Container(
        margin: const EdgeInsets.only(right: 50),
        child: ValueListenableBuilder(
          valueListenable: notifier,
          builder: (context, size, _) {
            if (isRendered.value == false) {
              return Wrap(
                clipBehavior: Clip.hardEdge,
                children: [
                  ...List.generate(
                    names.length,
                    (index) {
                      return RoundedFilledChip(
                        text: names[index],
                      );
                    },
                  )
                ],
              );
            } else {
              return Stack(
                children: [
                  AnimatedContainer(
                    height: !isExpanded.value ? 36 : originHeight.value,
                    color: Colors.red,
                    duration: const Duration(milliseconds: 200),
                    child: Wrap(
                      clipBehavior: Clip.hardEdge,
                      children: [
                        ...List.generate(
                          names.length,
                          (index) {
                            return Stack(
                              children: [
                                RoundedFilledChip(
                                  text: names[index],
                                ),
                                if (isExpanded.value.isTrue &&
                                    index + 1 == names.length)
                                  Positioned(
                                    right: -40,
                                    child: DeferPointer(
                                      paintOnTop: true,
                                      child: GestureDetector(
                                        onTap: () {
                                          print('우지랑이');
                                          isExpanded.value = false;
                                        },
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  // SHOW MORE BTN
                  if (isOverflowed.value.isTrue)
                    Positioned(
                      bottom: 0,
                      right: -40,
                      child: DeferPointer(
                        paintOnTop: true,
                        child: IgnorePointer(
                          ignoring: isExpanded.value.isTrue,
                          child: GestureDetector(
                            onTap: () {
                              isExpanded.value = true;
                            },
                            child: AnimatedOpacity(
                              opacity: isExpanded.value.isFalse ? 1 : 0,
                              duration: const Duration(milliseconds: 200),
                              child: Container(
                                width: 24,
                                height: 24,
                                color: Colors.yellow,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
