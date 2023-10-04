import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';

class ClearableTextField extends HookWidget {
  const ClearableTextField({
    super.key,
    this.focusNode,
    this.controller,
    this.initialValue,
    this.style,
    this.inputDecoration,
    this.onClear,
    this.onChanged,
    this.obscureText = false,
    this.enabled = true,
    this.activeSuffixIcon = true,
    this.autoFocus = false,
    this.inputFormatters,
    this.keyboardType,
  });

  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? initialValue;
  final TextStyle? style;
  final InputDecoration? inputDecoration;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final bool enabled;
  final bool autoFocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  /// 우측 아이콘을 활성화할지 여부
  final bool activeSuffixIcon;

  /// 클리어 아이콘을 눌렀을 때 실행할 콜백
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final controller =
        this.controller ?? useTextEditingController(text: initialValue);
    final isFieldEmpty = useListenableSelector(
      controller,
      () => controller.text.isEmpty,
    );
    var inputDecoration = this.inputDecoration ?? const InputDecoration();
    inputDecoration = inputDecoration.copyWith(
      suffixIcon: activeSuffixIcon && !isFieldEmpty
          ? _buildClearIcon(controller)
          : null,
    );

    return TextField(
      focusNode: focusNode,
      controller: controller,
      autofocus: autoFocus,
      enabled: enabled,
      obscureText: obscureText,
      style: style,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      decoration: inputDecoration,
      onChanged: onChanged,
    );
  }

  Widget _buildClearIcon(TextEditingController controller) {
    return IconButton(
      onPressed: () {
        controller.clear();
        onClear?.call();
      },
      icon: FaIcon(
        FontAwesomeIcons.solidCircleXmark,
        size: 16,
        color: AppColor.of.gray2,
      ),
    );
  }
}

/// 클리어 버튼이 있는 텍스트 폼 필드
///
/// [activeSuffixIcon] 값에 따라 아이콘을 표시 또는 표시하지 않으며 기본 아이콘은 클리어 아이콘이다.
class ClearableTextFormField extends HookWidget {
  const ClearableTextFormField({
    super.key,
    this.focusNode,
    this.controller,
    this.initialValue,
    this.style,
    this.inputDecoration,
    this.onClear,
    this.onChanged,
    this.obscureText = false,
    this.validator,
    this.enabled = true,
    this.activeSuffixIcon = true,
    this.autoFocus = false,
    this.inputFormatters,
    this.keyboardType,
  });

  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? initialValue;
  final TextStyle? style;
  final InputDecoration? inputDecoration;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final bool enabled;
  final bool autoFocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final ValueChanged<String>? validator;

  /// 우측 아이콘을 활성화할지 여부
  final bool activeSuffixIcon;

  /// 클리어 아이콘을 눌렀을 때 실행할 콜백
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final controller =
        this.controller ?? useTextEditingController(text: initialValue);
    final isFieldEmpty = useListenableSelector(
      controller,
      () => controller.text.isEmpty,
    );
    var inputDecoration = this.inputDecoration ?? const InputDecoration();
    inputDecoration = inputDecoration.copyWith(
      helperStyle: PretendardTextStyle.alert2.copyWith(
        color: inputDecoration.errorText != null
            ? AppColor.of.red2
            : AppColor.of.brand2,
      ),
      suffixIcon: activeSuffixIcon && !isFieldEmpty
          ? _ClearIconButton(
              controller: controller,
              onTap: onClear,
            )
          : null,
    );
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      autofocus: autoFocus,
      enabled: enabled,
      obscureText: obscureText,
      style: style ?? PretendardTextStyle.body1,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      decoration: inputDecoration,
      onChanged: onChanged,
    );
  }
}

class _ClearIconButton extends StatelessWidget {
  const _ClearIconButton({
    super.key,
    required this.controller,
    this.onTap,
  });

  final TextEditingController controller;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        controller.clear();
        onTap?.call();
      },
      icon: FaIcon(
        FontAwesomeIcons.solidCircleXmark,
        size: 16,
        color: AppColor.of.gray2,
      ),
    );
  }
}
