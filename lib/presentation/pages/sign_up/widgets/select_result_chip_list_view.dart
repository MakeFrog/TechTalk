import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class SelectResultChipListView extends StatelessWidget {
  const SelectResultChipListView({
    super.key,
    required this.itemList,
    this.onTapItem,
  });

  final List<String> itemList;
  final void Function(int index)? onTapItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: itemList.length,
        separatorBuilder: (context, index) => const Gap(8),
        itemBuilder: (context, index) {
          final item = itemList[index];

          return Align(
            alignment: Alignment.topCenter,
            child: ClosableRectFilledChip(
              label: item,
              onTap: () => onTapItem?.call(index),
            ),
          );
        },
      ),
    );
  }
}
