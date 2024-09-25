import 'package:flutter/material.dart';

///
/// [AnimatedSizeAndFade] 패키지 소스코드
/// https://github.com/marcglasberg/animated_size_and_fade
/// 일부 속성을 재정의하여 사용
///
class AnimatedSizeAndFade extends StatelessWidget {
  static final _key = UniqueKey();

  final Widget? child;
  final Duration fadeDuration;
  final Duration sizeDuration;
  final Curve fadeInCurve;
  final Curve fadeOutCurve;
  final Curve sizeCurve;
  final Alignment alignment;
  final bool show;

  const AnimatedSizeAndFade({
    Key? key,
    this.child,
    this.fadeDuration = const Duration(milliseconds: 500),
    this.sizeDuration = const Duration(milliseconds: 500),
    this.fadeInCurve = Curves.easeInOut,
    this.fadeOutCurve = Curves.easeInOut,
    this.sizeCurve = Curves.easeInOut,
    this.alignment = Alignment.center,
  })  : show = true,
        super(key: key);

  /// Use this constructor when you want to show/hide the child, by doing a
  /// vertical size/fade. To that end, instead of changing the child,
  /// simply change [show]. Note this widget will try to have its width as
  /// big as possible, so put it in a parent with limited width constraints.
  const AnimatedSizeAndFade.showHide({
    Key? key,
    this.child,
    required this.show,
    this.fadeDuration = const Duration(milliseconds: 500),
    this.sizeDuration = const Duration(milliseconds: 500),
    this.fadeInCurve = Curves.easeInOut,
    this.fadeOutCurve = Curves.easeInOut,
    this.sizeCurve = Curves.easeInOut,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var animatedSizeView = AnimatedSwitcher(
          duration: fadeDuration,
          switchInCurve: fadeInCurve,
          switchOutCurve: fadeOutCurve,
          layoutBuilder: _layoutBuilder,
          child: show
              ? child
              : SizedBox(
            key: AnimatedSizeAndFade._key,
            width: constraints.maxWidth,
            height: 0,
          ),
        );

        // sizeDuration이 0이 아니면 AnimatedSize로 애니메이션 적용
        var animatedAdjustView = sizeDuration != Duration.zero
            ? AnimatedSize(
          duration: sizeDuration,
          curve: sizeCurve,
          child: animatedSizeView,
        )
            : animatedSizeView;

        return ClipRect(
          clipBehavior: Clip.none,
          child: animatedAdjustView,
        );
      },
    );
  }

  Widget _layoutBuilder(Widget? currentChild, List<Widget> previousChildren) {
    List<Widget> children = previousChildren;

    if (currentChild != null) {
      //
      children = previousChildren.isEmpty
          ? [currentChild]
          : [
              Positioned(
                left: 0,
                right: 0,
                child: previousChildren[0],
              ),
              currentChild,
            ];
    }

    return Stack(
      clipBehavior: Clip.none,
      alignment: alignment,
      children: children,
    );
  }
}
