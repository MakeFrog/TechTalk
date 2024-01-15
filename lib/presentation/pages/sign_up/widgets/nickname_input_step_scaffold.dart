part of '../steps/nickname_input_step.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold(
      {super.key,
      required this.introText,
      required this.textField,
      required this.bottomFixedBtn});

  final Widget introText;
  final Widget textField;
  final Widget bottomFixedBtn;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        introText,
        const Gap(24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: textField,
        ),
        const Spacer(),
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(bottom: AppSize.to.bottomInset) +
              const EdgeInsets.symmetric(horizontal: 16),
          child: bottomFixedBtn,
        )
      ],
    );
  }
}
