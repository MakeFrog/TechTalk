import 'package:flutter/widgets.dart';

class SquareBox extends SizedBox {
  const SquareBox(
    double dimension, [
    Key? key,
  ]) : super(
          key: key,
          width: dimension,
          height: dimension,
        );
}

class HeightBox extends SizedBox {
  const HeightBox(
    double height, [
    Key? key,
  ]) : super(
          key: key,
          height: height,
          width: 0,
        );
}

class WidthBox extends SizedBox {
  const WidthBox(
    double width, [
    Key? key,
  ]) : super(
          key: key,
          width: width,
          height: 0,
        );
}

class EmptyBox extends SizedBox {
  const EmptyBox({super.key}) : super.shrink();
}
