import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/presentation/pages/study/learning/learning_detail_event.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_answer_blur_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/widgets/learning_detail_state.dart';
import 'package:techtalk/presentation/pages/study/learning/widgets/study_progress_indicator.dart';
import 'package:techtalk/presentation/pages/study/learning/widgets/study_qna_view.dart';
import 'package:techtalk/presentation/pages/study/topic_selection/providers/selected_study_topic_provider.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/button/icon_flash_area_button.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

part 'widgets/learning_detail_bottom_controller_bar.dart';
part 'widgets/learning_detail_page_app_bar.dart';

class LearningDetailPage extends BasePage with LearningDetailState {
  const LearningDetailPage({
    super.key,
  });

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return qnasAsync(ref).when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text('$error'),
      ),
      data: (questions) {
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(24),
            StudyProgressIndicator(),
            Gap(5),
            StudyQnaView(),
          ],
        );
      },
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const _AppBar();

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation =>
      FloatingActionButtonLocation.centerDocked;

  @override
  Widget? buildFloatingActionButton(WidgetRef ref) {
    return const _BottomControllerBar();
  }
}
