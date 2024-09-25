import 'package:flutter/material.dart';

class StaggeredDotsWave extends StatefulWidget {
  final double size;
  final Color color;
  final double maxHeightFactor;
  final AnimationController controller;

  const StaggeredDotsWave({
    Key? key,
    required this.size,
    required this.color,
    required this.controller,
    this.maxHeightFactor = 1.5,
  }) : super(key: key);

  @override
  State<StaggeredDotsWave> createState() => _StaggeredDotsWaveState();
}

class _StaggeredDotsWaveState extends State<StaggeredDotsWave> {
  @override
  Widget build(BuildContext context) {
    final double oddDotHeight = widget.size * 0.4 * widget.maxHeightFactor;
    final double evenDotHeight = widget.size * 0.7 * widget.maxHeightFactor;

    return Container(
      alignment: Alignment.center,
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (_, __) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            DotContainer(
              controller: widget.controller,
              heightInterval: const Interval(0.0, 0.1),
              offsetInterval: const Interval(0.18, 0.28),
              reverseHeightInterval: const Interval(0.28, 0.38),
              reverseOffsetInterval: const Interval(0.47, 0.57),
              color: widget.color,
              size: widget.size,
              maxHeight: oddDotHeight,
            ),
            DotContainer(
              controller: widget.controller,
              heightInterval: const Interval(0.09, 0.19),
              offsetInterval: const Interval(0.27, 0.37),
              reverseHeightInterval: const Interval(0.37, 0.47),
              reverseOffsetInterval: const Interval(0.56, 0.66),
              color: widget.color,
              size: widget.size,
              maxHeight: evenDotHeight,
            ),
            DotContainer(
              controller: widget.controller,
              heightInterval: const Interval(0.18, 0.28),
              offsetInterval: const Interval(0.36, 0.46),
              reverseHeightInterval: const Interval(0.46, 0.56),
              reverseOffsetInterval: const Interval(0.65, 0.75),
              color: widget.color,
              size: widget.size,
              maxHeight: oddDotHeight,
            ),
          ],
        ),
      ),
    );
  }
}

class DotContainer extends StatelessWidget {
  final Interval offsetInterval;
  final double size;
  final Color color;
  final Interval reverseOffsetInterval;
  final Interval heightInterval;
  final Interval reverseHeightInterval;
  final double maxHeight;
  final AnimationController controller;

  const DotContainer({
    Key? key,
    required this.offsetInterval,
    required this.size,
    required this.color,
    required this.reverseOffsetInterval,
    required this.heightInterval,
    required this.reverseHeightInterval,
    required this.maxHeight,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double maxDy = -(size * 0.20);

    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        // Calculate current height and offset
        final double currentHeight = Tween<double>(
          begin: size * 0.13,
          end: maxHeight,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: heightInterval,
        )).value;

        final Offset currentOffset = Tween<Offset>(
          begin: Offset.zero,
          end: Offset(0, maxDy),
        ).animate(CurvedAnimation(
          parent: controller,
          curve: offsetInterval,
        )).value;

        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Opacity(
              opacity: controller.value <= offsetInterval.end ? 1 : 0,
              child: Transform.translate(
                offset: currentOffset,
                child: Container(
                  width: size * 0.15,
                  height: currentHeight,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(size),
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: controller.value >= offsetInterval.end ? 1 : 0,
              child: Transform.translate(
                offset: Tween<Offset>(
                  begin: Offset(0, maxDy),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: controller,
                  curve: reverseOffsetInterval,
                )).value,
                child: Container(
                  width: size * 0.13,
                  height: Tween<double>(
                    end: size * 0.13,
                    begin: maxHeight,
                  ).animate(CurvedAnimation(
                    parent: controller,
                    curve: reverseHeightInterval,
                  )).value,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(size),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

