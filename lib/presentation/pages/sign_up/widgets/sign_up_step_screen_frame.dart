import 'package:flutter/material.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

/// 회원가입 단계 스크린 틀
///
/// 안내 메세지와 사용자와 상호작용하는 바디, 다음 또는 완료 버튼으로 구성되어있다.
class SignUpStepScreenFrame extends StatelessWidget {
  const SignUpStepScreenFrame({
    super.key,
    required this.stepTitle,
    required this.stepDesc,
    required this.content,
    this.onTapNext,
  });

  final String stepTitle;
  final String stepDesc;
  final Widget content;
  final VoidCallback? onTapNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoSection(),
          content,
          const Spacer(),
          FilledButton(
            onPressed: onTapNext,
            child: const Center(
              child: Text('다음'),
            ),
          ),
        ],
      ),
    );
  }

  // 회원가입 단계를 설명하는 제목과 부제목 위젯
  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stepTitle,
          style: AppTextStyle.headline1,
        ),
        const HeightBox(12),
        Text(
          stepDesc,
          style: AppTextStyle.body1.copyWith(
            color: AppColor.of.gray4,
          ),
        ),
      ],
    );
  }
}
