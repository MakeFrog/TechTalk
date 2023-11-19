import 'package:flutter/material.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class ReviewNoteTopicListView extends StatelessWidget {
  const ReviewNoteTopicListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      margin: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        itemCount: itemCount,
        separatorBuilder: (context, index) => const WidthBox(8),
        itemBuilder: itemBuilder,
      ),
    );
  }
}
