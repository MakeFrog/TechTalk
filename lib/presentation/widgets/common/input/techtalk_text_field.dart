import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/widgets/common/box/empty_box.dart';

class TechtalkTextField extends HookWidget {
  const TechtalkTextField({
    super.key,
    this.focusNode,
    this.controller,
    this.initialValue,
    this.style,
    InputDecoration? inputDecoration,
    this.onClear,
    this.onChanged,
    this.onEditingComplete,
    this.obscureText = false,
    this.enabled = true,
    this.activeSuffixIcon = true,
    this.autoFocus = false,
    this.validator,
    this.inputFormatters,
    this.textInputAction,
    this.keyboardType,
    this.hintText,
    this.hintTextStyle,
  }) : inputDecoration = inputDecoration ?? const InputDecoration();

  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? initialValue;
  final TextStyle? style;
  final InputDecoration inputDecoration;
  final ValueChanged<String>? onChanged;
  final void Function()? onEditingComplete;
  final bool obscureText;
  final bool enabled;
  final bool autoFocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String? value)? validator;
  final String? hintText;
  final TextStyle? hintTextStyle;

  /// 우측 아이콘을 활성화할지 여부
  final bool activeSuffixIcon;

  /// 클리어 아이콘을 눌렀을 때 실행할 콜백
  final VoidCallback? onClear;

  bool isFieldEmpty(TextEditingController controller) {
    return useListenableSelector(
      controller,
      () => controller.text.isEmpty,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller =
        this.controller ?? useTextEditingController(text: initialValue);
    final inputDecoration = this.inputDecoration.copyWith(
          hintText: hintText,
          hintStyle: hintTextStyle,
          suffixIcon: activeSuffixIcon && !isFieldEmpty(controller)
              ? _buildClearIcon(controller)
              : null,
          errorStyle: AppTextStyle.body2.copyWith(
            color: AppColor.of.red2,
          ),
          contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
              ) +
              const EdgeInsets.only(right: 16),
          prefix: const Padding(
            padding: EdgeInsets.only(
              left: 16.0,
            ),
          ),
        );

    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      autofocus: autoFocus,
      validator: validator,
      enabled: enabled,
      obscureText: obscureText,
      style: style,
      cursorColor: AppColor.of.brand2,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      decoration: inputDecoration,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
    );
  }

  Widget _buildClearIcon(TextEditingController controller) {
    return IconButton(
      onPressed: onClear != null
          ? () {
              if (this.controller == null) {
                controller.clear();
              }
              onClear!();
            }
          : () => controller.clear(),
      icon: SvgPicture.asset(
        Assets.iconsRoundedCloseThick,
        width: 22,
      ),
    );
  }
}
