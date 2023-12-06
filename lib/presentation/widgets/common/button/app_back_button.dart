import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:techtalk/core/constants/assets.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.onBackBtnTapped,
  });

  final VoidCallback? onBackBtnTapped;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IconButton(
        onPressed: onBackBtnTapped ?? context.pop,
        icon: SvgPicture.asset(Assets.iconsArrowLeft),
      ),
    );
  }
}
