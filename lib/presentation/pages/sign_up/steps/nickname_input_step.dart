import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/services/size_service.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/providers/input/nickname_input_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

part '../widgets/bottom_fixed_btn.dart';
part '../widgets/nickname_input_field.dart';
part '../widgets/nickname_input_step_scaffold.dart';

class NicknameInputStep extends StatelessWidget {
  const NicknameInputStep({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return _Scaffold(
      introText: const SignUpStepIntroMessage(
        title: '안녕하세요. 테크톡으로\n면접을 준비해볼까요?',
        subTitle: '먼저 사용할 닉네임이 필요해요.',
      ),
      textField: _NicknameInputField(formKey),
      bottomFixedBtn: _BottomFixedBtn(formKey),
    );
  }
}
