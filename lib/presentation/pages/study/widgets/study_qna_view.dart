import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class StudyQnaView extends StatelessWidget {
  const StudyQnaView({
    super.key,
    required this.controller,
    this.onChangeQuestion,
    required this.itemCount,
    required this.isBlur,
  });

  final PageController controller;
  final void Function(int value)? onChangeQuestion;
  final int itemCount;
  final bool isBlur;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: controller,
        onPageChanged: onChangeQuestion,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: Text(
                  'Self와 self의 차이는 무엇인가요?',
                  style: AppTextStyle.title1,
                ),
              ),
              HeightBox(8.h),
              Expanded(
                child: ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColor.of.gray2,
                          ),
                        ),
                      ),
                      child: isBlur
                          ? ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: 4,
                                sigmaY: 4,
                              ),
                              child: Text(
                                'Self는 프로토콜에서 사용되면 프로토콜을 채택하는 타입을 의미하고, 클래스, 구조체, 열거형에서 사용되면 실제 선언에 사용된 타입을 의미합니다.',
                                style: AppTextStyle.body2,
                              ),
                            )
                          : Text(
                              'Self는 프로토콜에서 사용되면 프로토콜을 채택하는 타입을 의미하고, 클래스, 구조체, 열거형에서 사용되면 실제 선언에 사용된 타입을 의미합니다.',
                              style: AppTextStyle.body2,
                            ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
