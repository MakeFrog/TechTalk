import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClipOvalCircleAvatar extends StatelessWidget {
  const ClipOvalCircleAvatar(
      {Key? key, required this.svgPath, required this.size})
      : super(key: key);

  final String svgPath;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: ClipOval(
            child: SvgPicture.asset(
              svgPath,
              width: size,
              height: size,
            ),
          ),
        ),
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ],
    );
  }
}
