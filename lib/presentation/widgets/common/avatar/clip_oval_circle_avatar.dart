import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/presentation/widgets/common/box/skeleton_box.dart';

class ClipOvalCircleAvatar extends StatelessWidget {
  const ClipOvalCircleAvatar(
      {Key? key,
      required this.svgPath,
      required this.size,
      required this.isLoaded})
      : super(key: key);

  factory ClipOvalCircleAvatar.create(
          {required String svgPath, required double size}) =>
      ClipOvalCircleAvatar(svgPath: svgPath, size: size, isLoaded: true);
  factory ClipOvalCircleAvatar.createSkeleton({required double size}) =>
      ClipOvalCircleAvatar(svgPath: null, size: size, isLoaded: false);

  final String? svgPath;
  final double size;
  final bool isLoaded;

  @override
  Widget build(BuildContext context) {
    if (isLoaded) {
      return Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: ClipOval(
              child: SvgPicture.asset(
                svgPath!,
                width: size,
                height: size,
              ),
            ),
          ),
          Container(
            height: size,
            width: size,
            decoration: const BoxDecoration(shape: BoxShape.circle),
          ),
        ],
      );
    } else {
      return Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: ClipOval(
                child: SkeletonBox(
              height: size,
              width: size,
              borderRadius: size / 2,
            )),
          ),
          Container(
            height: size,
            width: size,
            decoration: const BoxDecoration(shape: BoxShape.circle),
          ),
        ],
      );
    }
  }
}
