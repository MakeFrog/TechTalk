import 'package:flutter/material.dart';

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
