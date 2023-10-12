import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:techtalk/presentation/widgets/common/chip/selected_filled_chip.dart';

class SelectResultChipListView extends StatelessWidget {
  const SelectResultChipListView({
    super.key,
    this.stateKey,
    required this.itemList,
    this.onTapItem,
  });

  final GlobalKey<AnimatedListState>? stateKey;
  final List<String> itemList;
  final void Function(int index)? onTapItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: AnimatedList(
        key: stateKey,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        initialItemCount: itemList.length,
        itemBuilder: (context, index, animation) {
          return _buildFadeInItem(
            index,
            animation,
          );
        },
      ),
    );
  }

  Widget _buildItem(int index) {
    final item = itemList[index];

    Widget chip = SelectedFilledChip(
      label: item,
      onTap: () => onTapItem?.call(index),
    );

    if (index + 1 != itemList.length) {
      chip = Padding(
        padding: const EdgeInsets.only(right: 8),
        child: chip,
      );
    }

    return chip;
  }

  Widget _buildFadeInItem(int index, Animation<double> animation) {
    final item = _buildItem(index);

    return item
        .animate()
        .scaleX(
          alignment: Alignment.centerLeft,
          begin: 0,
          end: 1,
          curve: Curves.easeOutExpo,
          duration: 100.ms,
        )
        .then()
        .fadeIn(
          duration: 200.ms,
        );
  }
}
