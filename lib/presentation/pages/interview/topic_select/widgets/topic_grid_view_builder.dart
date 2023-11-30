import 'package:flutter/material.dart';

class TopicGridViewBuilder extends StatelessWidget {
  const TopicGridViewBuilder(
      {Key? key, required this.itemBuilder, required this.itemCount})
      : super(key: key);

  final NullableIndexedWidgetBuilder itemBuilder;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 11,
        mainAxisSpacing: 12,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
