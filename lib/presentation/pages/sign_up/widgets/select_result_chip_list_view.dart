import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techtalk/presentation/widgets/common/chip/rounded_rect_filled_chip.dart';
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
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: itemList.length,
        separatorBuilder: (context, index) => WidthBox(8.w),
        itemBuilder: (context, index) {
          final item = itemList[index];

          return Align(
            alignment: Alignment.topCenter,
            child: RoundedRectFilledChip(
              label: item,
              onTap: () => onTapItem?.call(index),
            ),
          );
        },
      ),
    );
  }
}
