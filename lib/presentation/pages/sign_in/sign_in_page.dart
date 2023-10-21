import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/sign_in/widgets/start_with_apple_button.dart';
import 'package:techtalk/presentation/pages/sign_in/widgets/start_with_google_button.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.of.white,
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          _buildWelcomeSection(),
          const Spacer(),
          _buildSignInButtonSection(),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      children: [
        SvgPicture.asset(
          Assets.logoTechTalkLogo,
          width: 114.w,
        ),
        HeightBox(8.h),
        Center(
          child: Text(
            'AI 면접관과 톡톡!',
            style: AppTextStyle.pretendardBoldStyle(24.sp, 33.sp),
          ),
        ),
        HeightBox(70.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: SvgPicture.asset(
            Assets.imagesWelcomeTechtalk,
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButtonSection() {
    return Column(
      children: [
        const StartWithGoogleButton(),
        HeightBox(8.h),
        const StartWithAppleButton(),
        HeightBox(48.h),
      ],
    );
  }
}
