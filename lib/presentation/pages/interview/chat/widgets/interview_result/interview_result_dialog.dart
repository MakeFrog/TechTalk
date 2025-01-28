import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_state.dart';
import 'package:techtalk/presentation/widgets/common/box/empty_box.dart';
import 'package:techtalk/presentation/widgets/common/image/thumbnail_image_view.dart';
import 'package:techtalk/presentation/widgets/common/indicator/interview_count_result_indicator.dart';

part 'interview_induction_view.p.dart';
part 'one_line_review_view.p.dart';
part 'pass_or_fail_view.p.dart';

///
/// 인터뷰가 종료된 이후 결과를 보여주는 다이어로그
///

class InterviewResultDialog extends ConsumerWidget with ChatState {
  const InterviewResultDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SizedBox(
        height: 367,
        child: PageView(
          controller: chatResultPageViewController(ref),
          children: const [
            /// 면접 성공 실패 인디케이터 뷰
            _PassOrFailView(),

            /// 면접관의 한줄평
            _OnLineView(),

            /// 다른 면접 유도 뷰
            _InterviewInductionView(),
          ],
        ),
      ),
    );
  }
}
