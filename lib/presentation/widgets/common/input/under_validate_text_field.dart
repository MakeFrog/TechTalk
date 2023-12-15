import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';

class UnderValidateTextField extends HookWidget {
  const UnderValidateTextField({
    super.key,
    required this.field,
    this.controller,
    this.validate,
    this.successText,
  });

  final TextEditingController? controller;
  final Widget Function(TextEditingController controller) field;
  final FutureOr<String?> Function(String value)? validate;
  final String? successText;

  @override
  Widget build(BuildContext context) {
    final controller = this.controller ?? useTextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        field(controller),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: HookBuilder(
            builder: (context) {
              final value = useListenableSelector(
                controller,
                () => controller.text,
              );
              final validate = useFuture(this.validate as Future<String?>?);

              if (value.isEmpty) {
                return SizedBox();
              }

              if (validate.connectionState == ConnectionState.waiting) {
                return const SizedBox.square(
                  dimension: 12,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              }

              if (validate.data != null) {
                return Text(
                  validate.data!,
                  style: AppTextStyle.alert2.copyWith(
                    color: AppColor.of.red2,
                  ),
                );
              } else {
                return Text(
                  successText ?? '',
                  style: AppTextStyle.alert2.copyWith(
                    color: AppColor.of.brand3,
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
