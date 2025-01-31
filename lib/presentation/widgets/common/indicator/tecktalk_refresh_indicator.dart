import 'package:flutter/material.dart';
import 'package:techtalk/app/style/app_color.dart';

class TechtalkRefreshIndicator extends StatelessWidget {
  const TechtalkRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  final Widget child;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppColor.of.white,
      color: AppColor.of.blue3,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
