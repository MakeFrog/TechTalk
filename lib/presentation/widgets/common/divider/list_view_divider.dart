import 'package:flutter/material.dart';
import 'package:techtalk/app/style/app_color.dart';

class ListViewDivider extends StatelessWidget {
  const ListViewDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return  Divider(
      color: AppColor.of.gray2,
      height: 32,
      thickness: 0.7,
    );
  }
}
