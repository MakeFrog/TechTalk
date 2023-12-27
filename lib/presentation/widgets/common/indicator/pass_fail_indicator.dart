import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/chat/chat.dart';

class PassFailIndicator extends StatelessWidget {
  const PassFailIndicator({Key? key, required this.status, required this.text})
      : super(key: key);

  final ChatResult status;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 6, 6, 6),
      decoration: BoxDecoration(
        color: status.isPassed ? AppColor.of.blue1 : AppColor.of.red1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: AppTextStyle.alert1.copyWith(
              color: status.isPassed ? AppColor.of.brand3 : AppColor.of.red2,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          SvgPicture.asset(
            status.isPassed ? Assets.iconsCheck : Assets.iconsClose,
            height: 16,
            width: 16,
            colorFilter: ColorFilter.mode(
                status.isPassed ? AppColor.of.brand3 : AppColor.of.red2,
                BlendMode.srcIn),
          )
        ],
      ),
    );
  }
}
