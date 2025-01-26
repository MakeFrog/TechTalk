import 'dart:async';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:techtalk/app/util/app_logger.dart';

int? _targetPoint;

class AimBounceTapper extends StatefulWidget {
  const AimBounceTapper({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.onLongPressUp,
    this.shrinkScaleFactor = 0.965,
    this.shrinkCurve = Curves.easeInSine,
    this.growCurve = Curves.easeOutSine,
    this.shrinkDuration = const Duration(milliseconds: 160),
    this.growDuration = const Duration(milliseconds: 120),
    this.delayedDurationBeforeGrow = const Duration(milliseconds: 60),
    this.highlightBorderRadius,
    this.highlightColor = const Color(0x1F939BAC),
    this.enable = true,
    this.blockTapOnLongPressEvent = true,
    this.disableBounceOnScroll = true,
    this.scrollController,
  }) : assert(shrinkScaleFactor > 0 && shrinkScaleFactor <= 1,
            'shrinkScaleFactor must be greater than 0 and less than or equal to 1');

  /// The child widget that will have the shrink/grow animation applied.
  final Widget child;

  /// Callback methods for various touch interactions.
  final Function()? onTap, onLongPress, onLongPressUp;

  /// The closer to 0, the more it will shrink.
  /// Values between 0 and 1 (exclusive) are valid.
  final double shrinkScaleFactor;

  /// The curve for shrink and grow animations.
  final Curve shrinkCurve, growCurve;

  /// The duration for the shrink and grow animations.
  final Duration shrinkDuration, growDuration;

  /// Delay before the grow animation starts after the shrink animation completes.
  ///
  /// You can set it to [Duration.zero] to remove the delay, but a small delay provides a smoother effect.
  final Duration delayedDurationBeforeGrow;

  /// Whether the shrink and grow animations are enabled.
  ///
  /// Set this to [false] to disable the animation.
  final bool enable;

  /// Border radius for the highlight overlay widget.
  final BorderRadius? highlightBorderRadius;

  /// Color that will be highlighted when the widget is tapped.
  final Color highlightColor;

  /// Whether to enable grow animation when scrolling.
  ///
  /// If true, the grow animation will be disabled while scrolling.
  final bool disableBounceOnScroll;

  /// Controls whether a tap event is blocked if a long press event occurs.
  ///
  /// If set to [true], the tap event will not be triggered after a long press.
  final bool blockTapOnLongPressEvent;

  /// Scroll controller for handling interactions during scrolling.
  ///
  /// If this is not provided, the widget tries to use the nearest available scroll controller.
  /// When nesting multiple scroll views, this property should be explicitly set.
  final ScrollController? scrollController;

  @override
  State<StatefulWidget> createState() => _AimBounceTapperState();
}

class _AimBounceTapperState extends State<AimBounceTapper>
    with SingleTickerProviderStateMixin<AimBounceTapper>, _Event {
  /// Animation controller to manage animation states.
  late final AnimationController _controller;

  /// The shrink and grow animation value.
  late final Animation<double> _animation;

  /// Scroll controller for listening to scroll events and triggering specific actions.
  ScrollController? _scrollController;

  /// Key for the touch area widget.
  final GlobalKey _touchAreaKey = GlobalKey();

  /// Target border radius for the child widget.
  BorderRadiusGeometry? targetRadius;

  /// LongPress timer to trigger the onLongPress callback.
  Timer? _longPressTimer;

  /// Whether the long press event has been triggered.
  bool _isLongPressed = false;

  /// Disables bounce animations during scrolling.
  void _disableBounceOnScroll() async {
    if (!widget.enable ||
        !_controller.isForwardOrCompleted ||
        _targetPoint == null) {
      return;
    }

    await _controller.reverse();
    resetProcessConfigs(this);
  }

  /// Handles cases where [onPointerUp] is not triggered after [onPointerDown].
  /// This may occur in rare scenarios, and [_targetPoint] is reset in such cases.
  void _initializePointerOnException(PointerEvent event) {
    if (_targetPoint != null && event is PointerCancelEvent) {
      _targetPoint = null;
    }
  }

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller and the animation with given curves and durations.
    _controller = AnimationController(
      vsync: this,
      duration: widget.shrinkDuration,
      reverseDuration: widget.growDuration,
    );
    _animation = Tween(begin: 1.0, end: widget.shrinkScaleFactor).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.shrinkCurve,
        reverseCurve: widget.growCurve,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        // Get the target border radius after the frame is rendered.
        if (widget.highlightBorderRadius == null) {
          targetRadius = getChildBorderCloseBorderRadius(context);
        }

        // Prevent mounting gaps with a small delay trick.
        await Future.delayed(Duration.zero);
        _scrollController = widget.scrollController != null &&
                (widget.scrollController?.hasClients ?? false)
            ? widget.scrollController
            : (mounted ? Scrollable.maybeOf(context)?.widget.controller : null);

        // Listen for scroll events to trigger the grow animation if enabled.
        if (_scrollController != null && widget.disableBounceOnScroll) {
          _scrollController?.addListener(_disableBounceOnScroll);
        }

        GestureBinding.instance.pointerRouter
            .addGlobalRoute(_initializePointerOnException);
      } catch (e) {
        log('catch Exception on initialization / This Exception is not Error: $e');
        resetProcessConfigs(this);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerCancel: (event) async {
        // 만약 이 취소 이벤트가 우리가 추적 중인 포인터라면 애니메이션/상태를 정리
        logger.f('아지랑이 1');
        if (_targetPoint == event.pointer) {
          logger.f('아지랑이 2');
          // 만약 shrink가 이미 진행 중이었다면 grow 애니메이션 없이 재빨리 되돌리는 식으로 정리
          if (_controller.isAnimating || _controller.isCompleted) {
            logger.f('아지랑이 3');
            await _controller.reverse();
          }
          logger.f('아지랑이 4');
          resetProcessConfigs(this);
        }
      },

      /// When a pointer moves within the widget.
      /// If the pointer moves outside the touch area, trigger the grow animation.
      onPointerMove: (event) async {
        try {
          if (!widget.enable) return;

          if (!isWithinBounds(
            position: event.localPosition,
            touchAreaSize: _touchAreaKey.currentContext?.size ?? Size.zero,
          )) {
            if (_controller.isCompleted) {
              await _controller.reverse();
              resetProcessConfigs(this);
            }
          }
        } catch (e) {
          log('Catch Exception on [onPointerMove] / This Exception is not Error: $e');
          resetProcessConfigs(this);
        }
      },

      /// When a pointer touches the display.
      /// Start the shrink animation and initialize the long press timer.
      onPointerDown: (event) async {
        bool success = false;
        try {
          if (!widget.enable ||
              _targetPoint != null ||
              _controller.isAnimating) {
            return;
          }
          _targetPoint = event.pointer;
          _controller.forward(); // shrink animation

          // long press timer 세팅
          if (widget.onLongPress != null || widget.onLongPressUp != null) {
            _longPressTimer = Timer(const Duration(milliseconds: 500), () {
              widget.onLongPress?.call();
              _isLongPressed = true;
            });
          }

          success = true;
        } catch (e, s) {
          log('PointerDown error: $e\n$s');
        } finally {
          // 혹시 throw가 발생해서 중간 리턴된 경우에도
          // “_targetPoint를 꼭 지워야 한다”면 여기서 reset할 수 있습니다.
          // 다만, 정상 터치 진행 시에는 reset하면 안 되므로, success 상태를
          // 체크해서 “이미 로직이 잘 진행됐으면” reset을 생략하도록 할 수도 있습니다.

          logger.f('아지랑이 : ${_targetPoint}');
          if (!success) {
            logger.f('아지랑이 온탭다운 해결 : ${_targetPoint}');
            // 로직이 비정상 종료라면 상태를 즉시 원복
            resetProcessConfigs(this);
          }
        }
      },

      /// When a pointer is lifted from the display.
      /// If lifted within the touch area, trigger the onTap or onLongPressUp callback and grow animation.
      onPointerUp: (event) async {
        logger.f('아지랑이 온탭업 : ${_targetPoint}');
        try {
          if (!widget.enable ||
              _controller.isDismissed ||
              _targetPoint != event.pointer) {
            return;
          }

          await _controller.forward();
          await Future.delayed(widget.delayedDurationBeforeGrow);

          _controller.reverse();

          Future.microtask(() async {
            if (_isLongPressed && widget.onLongPressUp != null) {
              await Future.value(widget.onLongPressUp!());
            } else if (widget.onTap != null) {
              await Future.value(widget.onTap!());
            }
          }).whenComplete(() async {
            await _controller.reverse();
            resetProcessConfigs(this);
          });
        } catch (e) {
          log('Catch Exception on [onPointerUp] / This Exception is not Error: $e');
          resetProcessConfigs(this);
        }
      },

      /// Build the widget with the shrink/grow animation applied.
      child: AnimatedBuilder(
        animation: _animation,
        child: widget.child,
        builder: (context, child) {
          return Transform.scale(
            key: _touchAreaKey,
            alignment: Alignment.center,
            scale: widget.enable ? _animation.value : 1.0,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // The child widget.
                child!,

                // Highlight color overlay.
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: targetRadius ??
                        widget.highlightBorderRadius ??
                        BorderRadius.zero,
                    child: IgnorePointer(
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          final opacity =
                              _animation.value == widget.shrinkScaleFactor
                                  ? 1.0
                                  : (1.0 - _animation.value) /
                                      (1.0 - widget.shrinkScaleFactor);
                          return Opacity(
                            opacity: opacity,
                            child: ColoredBox(
                              color: widget.highlightColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    try {
      _controller.stop();
      _controller.dispose();
      _longPressTimer?.cancel();
      if (_scrollController != null) {
        _scrollController?.removeListener(_disableBounceOnScroll);
      }
      GestureBinding.instance.pointerRouter
          .removeGlobalRoute(_initializePointerOnException);
    } catch (e) {
      log('catch Exception on Dispose state');
    }

    super.dispose();
  }
}

mixin class _Event {
  /// Checks if a pointer is within the bounds of the touch area.
  bool isWithinBounds({required Offset position, required Size touchAreaSize}) {
    return !(position.dx <= 0 ||
        position.dx >= touchAreaSize.width ||
        position.dy <= 0 ||
        position.dy >= touchAreaSize.height);
  }

  /// Finds the closest [BorderRadius] of a child widget within the widget tree.
  /// This method traverses the widget tree to find and return the closest non-zero [BorderRadius].
  BorderRadiusGeometry? getChildBorderCloseBorderRadius(BuildContext context) {
    try {
      BorderRadiusGeometry? closestBorderRadius;

      void inspectElement(Element element) {
        final renderObject = element.renderObject;
        if (renderObject is RenderBox) {
          final renderInfo = _getRenderInfoFromRenderObject(renderObject);
          if (context.size == renderInfo.size &&
              renderInfo.borderRadius != null &&
              renderInfo.borderRadius != BorderRadius.zero) {
            closestBorderRadius = renderInfo.borderRadius;
            return;
          }
        }

        element.visitChildren((childElement) {
          inspectElement(childElement);
          if (closestBorderRadius != null) return;
        });
      }

      final rootElement = context as Element;
      inspectElement(rootElement);

      return closestBorderRadius;
    } catch (e) {
      log('An issue occurred while retrieving the borderRadius of the target widget. This might be due to an unexpected error or require updates for compatibility with the Flutter version. $e');
      return null;
    }
  }

  /// Extracts BorderRadius from various types of RenderBox.
  ({Size size, BorderRadiusGeometry? borderRadius})
      _getRenderInfoFromRenderObject(RenderBox renderObject) {
    if (renderObject is RenderClipRRect) {
      return (size: renderObject.size, borderRadius: renderObject.borderRadius);
    }
    if (renderObject is RenderPhysicalModel) {
      return (size: renderObject.size, borderRadius: renderObject.borderRadius);
    }
    if (renderObject is RenderDecoratedBox) {
      final decoration = renderObject.decoration;
      if (decoration is BoxDecoration) {
        return (size: renderObject.size, borderRadius: decoration.borderRadius);
      } else if (decoration is ShapeDecoration) {
        final shape = decoration.shape;
        if (shape is RoundedRectangleBorder) {
          return (size: renderObject.size, borderRadius: shape.borderRadius);
        }
      }
    }
    if (renderObject is RenderPhysicalShape) {
      final CustomClipper<Path>? clipper = renderObject.clipper;
      if (clipper is ShapeBorderClipper) {
        final shape = clipper.shape;
        if (shape is RoundedRectangleBorder) {
          return (size: renderObject.size, borderRadius: shape.borderRadius);
        }
      }
    }
    return (size: renderObject.size, borderRadius: null);
  }

  /// Resets the process configuration settings for the bounce animation widget.
  void resetProcessConfigs(_AimBounceTapperState widget) {
    widget._longPressTimer?.cancel();
    widget._isLongPressed = false;
    _targetPoint = null;
  }
}
