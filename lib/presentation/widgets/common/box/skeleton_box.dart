import 'package:flutter/material.dart';

class SkeletonBox extends StatelessWidget {
  const SkeletonBox(
      {Key? key,
      this.padding,
      this.borderRadius = 4,
      this.height,
      this.width,
      this.color})
      : super(key: key);

  final double? borderRadius;
  final EdgeInsets? padding;
  final Color? color;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? const Color(0xFFE2E2E2),
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
        height: height,
        width: width,
      ),
    );
  }
}
