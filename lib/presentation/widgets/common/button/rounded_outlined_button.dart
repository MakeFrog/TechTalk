import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';

class RoundedOutlinedButton extends StatelessWidget {
  const RoundedOutlinedButton({
    super.key,
    required this.label,
    required this.onTap,
    this.padding,
    this.enabled = true,
  });

  final String label;
  final VoidCallback onTap;
  final EdgeInsets? padding;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero, // <-- 터치 영역을 고려한 padding
      child: BounceTapper(
        enable: enabled,
        onTap: onTap,
        child: Container(
          height: 28,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColor.of.gray1,
            ),
          ),
          child: Row(
            children: [
              Text(
                label,
                style: AppTextStyle.alert1.copyWith(
                    color: enabled ? AppColor.of.black : AppColor.of.gray3),
              )
            ],
          ),
        ),
      ),
    );
  }
}
