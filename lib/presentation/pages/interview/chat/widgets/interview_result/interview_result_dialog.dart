import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/widgets/common/indicator/interview_count_result_indicator.dart';

part 'pass_or_fail_view.p.dart';

part 'one_line_review_view.p.dart';

part 'interview_induction_view.p.dart';

class InterviewResultDialog extends HookConsumerWidget {
  const InterviewResultDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = usePageController(viewportFraction: 0.833);
    return Center(
      child: SizedBox(
        height: 367,
        child: PageView(
          controller: _controller,
          children: const [
            _InterviewInductionView(
              type: InterviewType.resume,
            ),
            _PassOrFailView(
              result: InterviewResult.pass,
              totalCount: 10,
              correctAnswerCount: 4,
            ),
            _OnLineView(),
          ],
        ),
      ),
    );
  }
}
