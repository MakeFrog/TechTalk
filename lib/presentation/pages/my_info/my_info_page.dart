import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class MyInfoPage extends BasePage {
  const MyInfoPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        HeightBox(32),

        /// 프로필 수정
        Row(
          children: [
            Text(
              '송송님!\n오늘도 열공하세요.',
              style: AppTextStyle.headline1,
            ),
            Spacer(),
            Container(
              width: 64,
              height: 64,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.of.background1,
              ),
              padding: EdgeInsets.only(top: 10),
              child: UnconstrainedBox(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.antiAlias,
                child: SvgPicture.asset(
                  Assets.iconsUser,
                  width: 64,
                  colorFilter: ColorFilter.mode(
                    AppColor.of.gray1,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
        HeightBox(6),
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: GestureDetector(
            child: Text(
              '정보 수정',
              style: AppTextStyle.alert1.copyWith(
                color: AppColor.of.gray3,
              ),
            ),
          ),
        ),
        HeightBox(40),

        /// 내 정보 수정
        Row(
          children: [
            Text(
              '내 정보',
              style: AppTextStyle.title1,
            ),
            Spacer(),
            GestureDetector(
              child: SvgPicture.asset(
                Assets.iconsPencil,
                width: 16,
              ),
            ),
          ],
        ),
        HeightBox(8),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: AppColor.of.background1,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '관심 직군',
                style: AppTextStyle.body3,
              ),
              HeightBox(8),
              SizedBox(
                height: 36,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.of.gray1,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '서버/백앤드 개발자',
                        style: AppTextStyle.body1.copyWith(
                          color: AppColor.of.gray5,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      Assets.iconsRoundedMore,
                    ),
                  ],
                ),
              ),
              HeightBox(16),
              Text(
                '관심 주제',
                style: AppTextStyle.body3,
              ),
              HeightBox(8),
              SizedBox(
                height: 36,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.of.gray1,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Swift',
                        style: AppTextStyle.body1.copyWith(
                          color: AppColor.of.gray5,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      Assets.iconsRoundedMore,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        HeightBox(24),

        /// 설정
        Text(
          '설정',
          style: AppTextStyle.title1,
        ),
        HeightBox(8),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: AppColor.of.background1,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '현재 버전 1.0.5',
                style: AppTextStyle.body2.copyWith(
                  color: AppColor.of.gray2,
                ),
              ),
              HeightBox(24),
              Text(
                '피드백 및 문의사항',
                style: AppTextStyle.body2.copyWith(
                  color: AppColor.of.gray2,
                ),
              ),
              HeightBox(24),
              Text(
                '개인정보 및 약관',
                style: AppTextStyle.body2.copyWith(
                  color: AppColor.of.gray2,
                ),
              ),
            ],
          ),
        ),
        HeightBox(24),

        /// 기타
        Text(
          '기타',
          style: AppTextStyle.title1,
        ),
        HeightBox(8),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: AppColor.of.background1,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '로그아웃',
                style: AppTextStyle.body2.copyWith(
                  color: AppColor.of.gray2,
                ),
              ),
              HeightBox(24),
              Text(
                '회원탈퇴',
                style: AppTextStyle.body2.copyWith(
                  color: AppColor.of.gray2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
