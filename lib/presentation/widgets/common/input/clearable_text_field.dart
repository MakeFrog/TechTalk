import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/core/core.dart';

class ClearableTextField extends HookWidget {
  const ClearableTextField({
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
          suffixIcon: activeSuffixIcon && !isFieldEmpty(controller)
              ? _buildClearIcon(controller)
              : null,
        );

    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      autofocus: autoFocus,
      validator: validator,
      enabled: enabled,
      obscureText: obscureText,
      style: style,
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
