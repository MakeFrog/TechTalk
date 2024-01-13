import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:techtalk/core/services/size_service.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';

class OptionListBottomSheet<T extends dynamic> extends StatelessWidget {
  const OptionListBottomSheet({
    Key? key,
    required this.options,
    required this.onOptionTapped,
    required this.onCloseBtnTapped,
    required this.leadingText,
  }) : super(key: key);

  final List<String> options;
  final void Function(int index) onOptionTapped;
  final VoidCallback onCloseBtnTapped;
  final String leadingText;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: context.pop,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16) +
              EdgeInsets.only(bottom: AppSize.to.bottomInset == 0 ? 12 : 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColor.of.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                width: double.infinity,
                child: Center(
                  child: Text(
                    leadingText,
                    style: AppTextStyle.alert2,
                  ),
                ),
              ),
              Container(
                height: 0.5,
                width: double.infinity,
                color: AppColor.of.gray2,
              ),
              ListView.separated(
                separatorBuilder: (_, __) => Container(
                  height: 0.5,
                  width: double.infinity,
                  color: AppColor.of.gray2,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return MaterialButton(
                    color: AppColor.of.white,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: options.length == index + 1
                          ? const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            )
                          : BorderRadius.zero,
                    ),
                    onPressed: () {
                      context.pop();
                      onOptionTapped(index);
                    },
                    child: SizedBox(
                      height: 56,
                      child: Center(
                        child: Text(
                          options[index],
                          style: AppTextStyle.title2,
                        ),
                      ),
                    ),
                  );
                },
              ),

              const Gap(8),
              // 하단 버튼
              MaterialButton(
                color: AppColor.of.white,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: onCloseBtnTapped,
                child: SizedBox(
                  height: 56,
                  child: Center(
                    child: Text(
                      '닫기',
                      style: AppTextStyle.title3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
