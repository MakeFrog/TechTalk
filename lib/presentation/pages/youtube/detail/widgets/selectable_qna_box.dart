import 'package:flutter/material.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/services/app_size.dart';
import 'package:techtalk/presentation/widgets/common/box/skeleton_box.dart';
import 'package:techtalk/presentation/widgets/common/checkbox/techtalk_checkbox.dart';

class SelectableQnaBox extends StatelessWidget {
  const SelectableQnaBox({
    super.key,
    required this.index,
    required this.question,
    required this.isSelected,
    required this.onTap,
    this.isLoaded = true,
  });

  final int index;
  final String question;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isLoaded;

  factory SelectableQnaBox.loading() {
    return SelectableQnaBox(
      index: 0,
      question: '',
      isSelected: false,
      onTap: () {},
      isLoaded: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? GestureDetector(
            onTap: onTap,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColor.of.blue1
                        : AppColor.of.background1,
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        (index + 1).toString(),
                        style: AppTextStyle.alert1.copyWith(
                          color: isSelected
                              ? AppColor.of.blue2
                              : AppColor.of.gray2,
                        ),
                      ),
                      SizedBox(
                        width: AppSize.ratioWidth(262),
                        child: Text(
                          question,
                          style: AppTextStyle.title1.copyWith(
                            color: isSelected
                                ? AppColor.of.black
                                : AppColor.of.gray3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: TechtalkCheckBox(
                    margin: const EdgeInsets.all(16),
                    value: isSelected,
                    onChanged: (_) {
                      onTap();
                    },
                  ),
                ),
              ],
            ),
          )
        : const SkeletonBox(
            borderRadius: 16,
            height: 92,
            width: double.infinity,
          );
  }
}
