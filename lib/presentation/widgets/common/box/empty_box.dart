import 'package:flutter/widgets.dart';

class SquareBox extends SizedBox {
  const SquareBox(
    double dimension, [
    Key? key,
  ]) : super.square(
          key: key,
          dimension: dimension,
        );
}

class EmptyBox extends SizedBox {
  const EmptyBox({super.key}) : super.shrink();
}
