import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
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
    required this.logoPath,
    this.subDescription,
    required this.onCardTapped,
    this.showNewBadge = false,
    this.showPlustBtn = true,
    this.onPlusSuffixedBtnTapped,
  });

  final String title;
  final String logoPath;
  final String? subDescription;
  final VoidCallback onCardTapped;
  final VoidCallback? onPlusSuffixedBtnTapped;
  final bool showPlustBtn;
  final bool showNewBadge;

  @override
  Widget build(BuildContext context) {
    return BounceTapper(
      onTap: onCardTapped,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 20, 0, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColor.of.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: subDescription != null
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(logoPath),
                  const Gap(4),
                  if (subDescription != null)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTitleRow(),
                          const Gap(4),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                              subDescription!,
                              style: AppTextStyle.body1.copyWith(
                                color: AppColor.of.gray3,
                              ),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Expanded(
                      child: _buildTitleRow(),
                    ),
                ],
              ),
            ),
            if (showPlustBtn) _buildPlusButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyle.headline3.copyWith(),
        ),
        if (showNewBadge)
          const NewBadge(
            margin: EdgeInsets.only(left: 6),
          )
      ],
    );
  }

  Widget _buildPlusButton() {
    return BounceTapper(
      highlightColor: Colors.transparent,
      onTap: onPlusSuffixedBtnTapped,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SvgPicture.asset(Assets.iconsRoundedPlus),
      ),
    );
  }
}
