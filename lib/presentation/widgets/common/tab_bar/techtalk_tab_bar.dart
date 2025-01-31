import 'package:flutter/material.dart';

class TechtalkTabBar extends Decoration {
  final double width;
  final double height; // 인디케이터 높이

  const TechtalkTabBar({required this.width, this.height = 2}); // 기본 높이 2

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(width: width, height: height);
  }
}

class _CustomPainter extends BoxPainter {
  final double width;
  final double height;

  _CustomPainter({required this.width, required this.height});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // 인디케이터의 위치와 크기 계산
    final double xCenter = offset.dx + (configuration.size!.width / 2);
    final double yBottom = configuration.size!.height - height; // 높이 반영
    final double startX = xCenter - (width / 2);
    final double endX = xCenter + (width / 2);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(startX, yBottom, endX, yBottom + height), // 높이 반영
        Radius.circular(height / 2), // 둥근 모서리
      ),
      paint,
    );
  }
}
