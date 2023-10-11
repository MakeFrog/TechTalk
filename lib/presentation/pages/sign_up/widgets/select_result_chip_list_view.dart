import 'package:flutter/material.dart';
import 'package:techtalk/presentation/widgets/common/chip/selected_filled_chip.dart';

class SelectResultChipListView extends StatelessWidget {
  const SelectResultChipListView({
    super.key,
    required this.itemList,
    this.onTapXMark,
  });

  final List<String> itemList;
  final void Function(int index)? onTapXMark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: AnimatedList(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        initialItemCount: itemList.length,
        itemBuilder: (context, index, animation) {
          final item = itemList[index];

          Widget chip = SelectedFilledChip(
            label: item,
            onTapXMark: () => onTapXMark?.call(index),
          );

          if (index + 1 != itemList.length) {
            chip = Padding(
              padding: const EdgeInsets.only(right: 8),
              child: chip,
            );
          }

          return chip;
        },
      ),
    );
  }
}
