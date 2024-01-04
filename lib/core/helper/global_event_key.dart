import 'package:flutter/material.dart';

///
/// 위젯에 할당된 [GlobalKey]값을 기반으로
/// 해당 위젯의 '높이' '넓이' 'x,y position' 값에 접근할 수 있도록
/// 도와주는 extension
///
extension GlobalKeyExtension on GlobalKey {
  RenderBox get renderBox {
    return currentContext?.findRenderObject() as RenderBox;
  }

  Offset get globalPosition {
    return renderBox.localToGlobal(Offset.zero);
  }

  double get height {
    return renderBox.size.height;
  }

  double get width {
    return renderBox.size.width;
  }

  double get left {
    return globalPosition.dx;
  }

  double get top {
    return globalPosition.dy;
  }

  double get distance {
    return globalPosition.distance;
  }
}
