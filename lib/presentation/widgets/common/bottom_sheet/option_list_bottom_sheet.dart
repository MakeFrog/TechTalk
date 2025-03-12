import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/services/app_size.dart';

class OptionListBottomSheet<T extends dynamic> extends ConsumerWidget {
  const OptionListBottomSheet({
    Key? key,
    required this.options,
    required this.onOptionTapped,
    required this.onCloseBtnTapped,
    required this.leadingText,
    this.highlightedIndexes = const {}, // 특정 인덱스를 강조하고 싶을때 ex) {2}
    this.highlightedTextColor = Colors.red, // 특정 인덱스 강조 색상
  }) : super(key: key);

  final List<T> options;
  final void Function(int index) onOptionTapped;
  final VoidCallback onCloseBtnTapped;
  final String leadingText;
  final Set<int> highlightedIndexes;
  final Color highlightedTextColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: context.pop,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16) +
              EdgeInsets.only(bottom: AppSize.bottomInset == 0 ? 12 : 0),
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
                  final item = options[index];
                  final isHighlighted = highlightedIndexes.contains(index);

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
                    onPressed: () => onOptionTapped(index),
                    child: SizedBox(
                      height: 56,
                      child: Center(
                        child: _buildWidgetItem(item, isHighlighted),
                      ),
                    ),
                  );
                },
              ),
              const Gap(8),
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
                      context.tr(LocaleKeys.common_close),
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

  /// options: List<T>
  dynamic _buildWidgetItem(T item, bool isHighlighted) {
    // T: String
    if (item is String) {
      return Text(
        item,
        style: isHighlighted
            ? AppTextStyle.title2.copyWith(color: highlightedTextColor)
            : AppTextStyle.title2,
      );
    }
    // T: String을 제외한 모든 dynamic
    return item;
  }
}
