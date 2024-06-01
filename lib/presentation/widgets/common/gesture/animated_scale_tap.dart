import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedScaleTap extends StatefulWidget {
  final List<BoxShadow>? boxShadow;
  final BorderRadius borderRadius;
  final EdgeInsets margin;
  final Widget child;
  final double begin, end;
  final Color? overlayColor;
  final GlobalKey? nestedButtonKey;
  final Duration beginDuration, endDuration;
  final Duration awaitDuration;
  final bool disableScaleAnimation;
  final Function()? onTap;
  final Curve beginCurve, endCurve;

  const AnimatedScaleTap({
    super.key,
    required this.child,
    this.borderRadius = BorderRadius.zero,
    this.boxShadow,
    this.nestedButtonKey,
    this.onTap,
    this.disableScaleAnimation = false,
    this.begin = 1.0,
    this.end = 0.965,
    this.margin = EdgeInsets.zero,
    this.overlayColor,
    this.beginDuration = const Duration(milliseconds: 140),
    this.endDuration = const Duration(milliseconds: 300),
    this.awaitDuration = const Duration(milliseconds: 200),
    this.beginCurve = Curves.decelerate,
    this.endCurve = Curves.fastOutSlowIn,
  });

  @override
  State<StatefulWidget> createState() => _AnimatedScaleTapState();
}

class _AnimatedScaleTapState extends State<AnimatedScaleTap>
    with SingleTickerProviderStateMixin<AnimatedScaleTap> {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.endDuration,
      value: 1.0,
      reverseDuration: widget.beginDuration,
    );
    _animation = Tween(begin: widget.end, end: widget.begin).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.beginCurve,
        reverseCurve: widget.endCurve,
      ),
    );
    _controller.forward();
  }

  bool isCallBackAvailable = false;

  @override
  Widget build(BuildContext context) {
    GlobalKey touchKey = GlobalKey();
    return GestureDetector(
      onTap: () async {
        if (widget.disableScaleAnimation) return;
        await Future.delayed(widget.awaitDuration);
        if (isCallBackAvailable) {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        }
        isCallBackAvailable = false;
        await _controller.forward();
      },
      child: Listener(
        key: touchKey,
        behavior: HitTestBehavior.translucent,
        onPointerMove: (details) {
          if (widget.disableScaleAnimation) return;
          if (touchKey.currentContext == null ||
              touchKey.currentContext?.size == null) return;
          if (!isCallBackAvailable) return;

          if (touchKey.currentContext!.size!.width < details.localPosition.dx ||
              details.localPosition.dx < 0 ||
              touchKey.currentContext!.size!.height <
                  details.localPosition.dy ||
              details.localPosition.dy < 0) {
            _controller.forward();
            isCallBackAvailable = false;
          }
        },
        onPointerDown: (c) async {
          if (widget.disableScaleAnimation) return;
          isCallBackAvailable = true;
          _controller.reverse();
        },
        onPointerUp: (c) async {
          if (isCallBackAvailable == true) {
            await Future.delayed(widget.awaitDuration);
            await _controller.forward();
          }
        },
        child: ScaleTransition(
          scale: _animation,
          child: Container(
            margin: widget.margin,
            decoration: BoxDecoration(
              boxShadow: widget.boxShadow,
            ),
            child: ClipRRect(
              borderRadius: widget.borderRadius,
              child: Stack(
                children: [
                  widget.child,
                  Positioned.fill(
                    child: IgnorePointer(
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (_, __) {
                          // Material Design, 12% overlay
                          const maxOpacity = 0.12;
                          final opacity = maxOpacity *
                              (1.0 -
                                  (_animation.value - 0.965) / (1.0 - 0.965));
                          return Container(
                            color: (widget.overlayColor ??
                                    const Color(0xFF939BAC))
                                .withOpacity(opacity.clamp(0.0, maxOpacity)),
                            // _animation.value > 0.982
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    return GestureDetector(
      child: Listener(
        key: touchKey,
        behavior: HitTestBehavior.translucent,
        onPointerMove: (details) {
          if (widget.disableScaleAnimation) return;
          if (touchKey.currentContext == null ||
              touchKey.currentContext?.size == null) return;
          if (!isCallBackAvailable) return;

          if (touchKey.currentContext!.size!.width < details.localPosition.dx ||
              details.localPosition.dx < 0 ||
              touchKey.currentContext!.size!.height <
                  details.localPosition.dy ||
              details.localPosition.dy < 0) {
            _controller.forward();
            isCallBackAvailable = false;
          }
        },
        onPointerDown: (c) async {
          if (widget.disableScaleAnimation) return;
          isCallBackAvailable = true;
          _controller.reverse();
        },
        onPointerUp: (c) async {
          if (widget.disableScaleAnimation) return;
          await Future.delayed(widget.awaitDuration);
          if (isCallBackAvailable) {
            if (widget.onTap != null) {
              widget.onTap!();
            }
          }
          isCallBackAvailable = false;
          await _controller.forward();
        },
        child: ScaleTransition(
          scale: _animation,
          child: Container(
            margin: widget.margin,
            decoration: BoxDecoration(
              boxShadow: widget.boxShadow,
            ),
            child: ClipRRect(
              borderRadius: widget.borderRadius,
              child: Stack(
                children: [
                  widget.child,
                  Positioned.fill(
                    child: IgnorePointer(
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (_, __) {
                          // Material Design, 12% overlay
                          const maxOpacity = 0.12;
                          final opacity = maxOpacity *
                              (1.0 -
                                  (_animation.value - 0.965) / (1.0 - 0.965));
                          return Container(
                            color: (widget.overlayColor ??
                                    const Color(0xFF939BAC))
                                .withOpacity(opacity.clamp(0.0, maxOpacity)),
                            // _animation.value > 0.982
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }
}
