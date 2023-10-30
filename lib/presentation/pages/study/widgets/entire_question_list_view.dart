import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class EntireQuestionListView extends StatelessWidget {
  const EntireQuestionListView({
    super.key,
    required this.itemCount,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            leading: BackButton(),
            title: Text(
              '전체 문항',
              style: AppTextStyle.headline2,
            ),
            titleSpacing: 0,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: 8.h,
              ),
              itemExtent: 68.h,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context, index);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 24.h,
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${index + 1}번',
                          style: AppTextStyle.body3.copyWith(
                            color: AppColor.of.gray3,
                          ),
                        ),
                        WidthBox(16.w),
                        Text(
                          'Self와 self의 차이는 무엇인가요?',
                          style: AppTextStyle.body1,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
