import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/presentation/widgets/common/indicator/new_badge.dart';

///
/// 홈 영역에서 사용되는 면접 타입별 카드 뷰
///
class InterviewIndicatorCard extends StatelessWidget {
  const InterviewIndicatorCard({
    super.key,
    required this.title,
    this.subDescription,
    required this.onCardTapped,
    this.showNewBadge = false,
    this.onPlusSuffixedBtnTapped,
  });

  final String title;
  final String? subDescription;
  final VoidCallback onCardTapped;
  final VoidCallback? onPlusSuffixedBtnTapped;
  final bool showNewBadge;

  @override
  Widget build(BuildContext context) {
    return BounceTapper(
      onTap: onCardTapped,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 0, 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColor.of.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.headline2.copyWith(
                        color: AppColor.of.brand3,
                      ),
                    ),
                    if (showNewBadge)
                      const NewBadge(
                        margin: EdgeInsets.only(left: 6),
                      )
                  ],
                ),
                BounceTapper(
                  highlightColor: Colors.transparent,
                  onTap: () {
                    onPlusSuffixedBtnTapped?.call();
                  },
                  child: SvgPicture.asset(Assets.iconsRoundBlueCircle),
                ),
              ],
            ),
            if (subDescription != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12, right: 24),
                child: Text(
                  subDescription!,
                  style: AppTextStyle.body1.copyWith(
                    color: AppColor.of.gray3,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
