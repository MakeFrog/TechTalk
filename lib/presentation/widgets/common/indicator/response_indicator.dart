import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/enums/follow_up_status.enum.dart';

class ResponseIndicator extends StatelessWidget {
  const ResponseIndicator({
    Key? key,
    required this.followupStatus,
    required this.chatResult,
    required this.text,
  }) : super(key: key);

  final ChatResult chatResult;
  final String text;
  final FollowupStatus followupStatus;

  @override
  Widget build(BuildContext context) {
    return followupStatus.isFollowup
        ? Row(
            children: [
              _buildPassFailIndicator(),
              const Gap(6),
              _buildFollowUpIndicator(),
            ],
          )

        /// 꼬리질문이 없을 때 정답,오답 인디케이터만 반환
        : _buildPassFailIndicator();
  }

  /// 정답,오답 인디케이터
  Widget _buildPassFailIndicator() {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 6, 6, 6),
      decoration: BoxDecoration(
        color: chatResult.isPassed ? AppColor.of.blue1 : AppColor.of.red1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: AppTextStyle.alert1.copyWith(
              color:
                  chatResult.isPassed ? AppColor.of.brand3 : AppColor.of.red2,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          SvgPicture.asset(
            chatResult.isPassed ? Assets.iconsCheck : Assets.iconsClose,
            height: 16,
            width: 16,
            colorFilter: ColorFilter.mode(
              chatResult.isPassed ? AppColor.of.brand3 : AppColor.of.red2,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }

  /// 꼬리질문 인디케이터
  Widget _buildFollowUpIndicator() {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 6, 6, 6),
      decoration: BoxDecoration(
        color: AppColor.of.purple1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Text(
            '꼬리질문', //TODO: Localization 적용해야함
            style: AppTextStyle.alert1.copyWith(
              color: AppColor.of.purple2,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          SvgPicture.asset(
            Assets.iconsStarDeco,
            height: 16,
            width: 16,
          ),
        ],
      ),
    );
  }
}
